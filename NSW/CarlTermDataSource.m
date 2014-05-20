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

@synthesize abbreviationList;


- (id)initWithVCBackref:(CarlTermViewController *)carlTermViewController {
    self = [super initWithVCBackref:carlTermViewController AndDataFromURL:@""];

    return self;
}

- (void)getRawDataFromURL:(NSString *)sourceURL {
    CarlTerm *test = [[CarlTerm alloc] initWithAbbreviation:@"CMC" LongName:@"The Center for Math and Computing"];
    CarlTerm *test2 = [[CarlTerm alloc] initWithAbbreviation:@"NSW" LongName:@"New Student Week"];
    abbreviationList = [[NSMutableArray alloc] init];

    [abbreviationList addObject:test];
    [abbreviationList addObject:test2];

    [myTableViewController setVCArrayToDataSourceArray:self.abbreviationList];
}


@end
