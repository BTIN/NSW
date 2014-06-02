//
// Created by Alex Simonides on 5/15/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNSWTableViewController.h"


@interface BaseNSWDataSource : NSObject {
    __weak BaseNSWTableViewController *myTableViewController;
}
// the time that the download started
@property (nonatomic, strong) NSDate *downloadStarted;

@property (nonatomic, strong) NSMutableData *localData;

// The list of objects specific to each dataSource (Events, CarlTerms, or Contacts)
@property (nonatomic, strong) NSArray *dataList;

- (id)initWithDataFromFile:(NSString *)localName;

- (id)initWithVCBackref:(BaseNSWTableViewController *)tableViewController
        AndDataFromFile:(NSString *)localName;

- (void)attachVCBackref:(BaseNSWTableViewController *)tableViewController;

- (void)logDownloadTime;

+(NSArray *)splitString:(NSString *)wholeString atCharactersInString:(NSString *)splitCharacters;

-(void)getRawDataFromURL:(NSURL *)sourceURL;

@end