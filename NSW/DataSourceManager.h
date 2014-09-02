//
// Created by Alex Simonides on 6/1/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EventDataSource;
@class ContactDataSource;
@class CarlTermDataSource;
@class FaqDataSource;


@interface DataSourceManager : NSObject

+ (id) sharedDSManager;

@property (nonatomic, strong, readonly) EventDataSource *eventDataSource;
@property (nonatomic, strong, readonly) ContactDataSource *contactDataSource;
@property (nonatomic, strong, readonly) CarlTermDataSource *carlTermDataSource;
@property (nonatomic, strong, readonly) FaqDataSource *faqDataSource;

@end