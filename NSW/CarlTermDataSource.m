//
//  DictionaryDataSource.m
//  NSW
//
//  Created by Alex Simonides on 5/13/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "CarlTermDataSource.h"
#import "CarlTerm.h"
#import "CarlTermViewController.h"



@implementation CarlTermDataSource

NSMutableArray * parsedCarlTerms;

- (id)initWithVCBackref:(CarlTermViewController *)carlTermViewController {
    self = [super initWithVCBackref:carlTermViewController AndDataFromURL:@"http://harrise.github.io/terms.json"];
    
    return self;
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [self parseAndSet:self.receivedData];
    
}
- (void)parseAndSet:(NSData *)JSONData {
    parsedCarlTerms = [[NSMutableArray alloc] init];
    NSDictionary *termlist = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    for(id key in termlist) {
        id value = [termlist objectForKey:key];
        CarlTerm * term = [[CarlTerm alloc] initWithAbbreviation:key LongName:value];
        [parsedCarlTerms addObject:term];
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"abbreviation" ascending:YES];
    [parsedCarlTerms sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    [myTableViewController setVCArrayToDataSourceArray:parsedCarlTerms];
}


@end
