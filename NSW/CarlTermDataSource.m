//
//  DictionaryDataSource.m
//  NSW
//
//  Created by Alex Simonides on 5/13/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "CarlTermDataSource.h"
#import "CarlTerm.h"



@implementation CarlTermDataSource

NSMutableArray * parsedCarlTerms;

- (id)initWithVCBackref:(CarlTermViewController *)carlTermViewController {
    self = [super initWithVCBackref:carlTermViewController
                    AndDataFromFile:@"terms.json"];
    
    return self;
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {

    [self parseAndSet:self.localData];
    [self logDownloadTime];
}
- (void)parseAndSet:(NSData *)JSONData {
    parsedCarlTerms = [[NSMutableArray alloc] init];
    NSDictionary *termlist = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    for(id key in termlist) {
        id value = termlist[key];
        CarlTerm * term = [[CarlTerm alloc] initWithAbbreviation:key LongName:value];
        [parsedCarlTerms addObject:term];
    }
    
    // "'Scrunch'" is getting placed at the top because of the single quotes...
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"abbreviation" ascending:YES];
    [parsedCarlTerms sortUsingDescriptors:@[sort]];
    [myTableViewController setVCArrayToDataSourceArray:parsedCarlTerms];
}


@end
