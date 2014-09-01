//
// Created by Alex Simonides on 5/15/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNSWTableViewController.h"


typedef NS_ENUM(NSInteger, NSWDataSourceType) {
    NSWDataSourceTypeEvent = 0,
    NSWDataSourceTypeContact,
    NSWDataSourceTypeCarlTerm,
    NSWDataSourceTypeFAQ
};

@interface BaseNSWDataSource : NSObject {
    __weak BaseNSWTableViewController *myTableViewController;
}
// the time that the download started
@property (nonatomic, strong, readonly) NSDate *downloadStartTime;

@property (nonatomic, strong) NSData *localData;
@property (nonatomic, strong) NSURL *url;

// The list of objects specific to each dataSource (Events, CarlTerms, or Contacts)
@property (nonatomic, strong) NSArray *dataList;

- (id)initWithDataFromFile:(NSString *)localName;

+ (instancetype)dataSourceOfType:(NSWDataSourceType)type;

+ (instancetype)dataSource;

- (void)attachVCBackref:(BaseNSWTableViewController *)tableViewController;

-(void)parseLocalData;

- (void)logDownloadTime;

+(NSArray *)splitString:(NSString *)wholeString atCharactersInString:(NSString *)splitCharacters;


@end