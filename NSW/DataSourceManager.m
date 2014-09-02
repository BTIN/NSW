//
// Created by Alex Simonides on 6/1/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "DataSourceManager.h"

#import "EventDataSource.h"
#import "ContactDataSource.h"
#import "CarlTermDataSource.h"
#import "FaqDataSource.h"


@interface DataSourceManager ()
@property (nonatomic, strong, readwrite) EventDataSource *eventDataSource;
@property (nonatomic, strong, readwrite) ContactDataSource *contactDataSource;
@property (nonatomic, strong, readwrite) CarlTermDataSource *carlTermDataSource;
@property (nonatomic, strong, readwrite) FaqDataSource *faqDataSource;
@end



@implementation DataSourceManager

#pragma mark ---- Initializers

static DataSourceManager *sharedDSManager = nil;

// Returns the singleton DataSourceManager
+(id)sharedDSManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedDSManager == nil) {
            sharedDSManager = [[self alloc] initPrivate];
        }
    });
    return sharedDSManager;
}

// this is a private init method (hidden). The real init method raise an exception. Like a real init method
// here we call [super init]
- (id)initPrivate {
    NSLog(@"Data Source Manager initialized.");
    if (self = [super init]) {
        self.eventDataSource = [[EventDataSource alloc] init];
        self.contactDataSource = [[ContactDataSource alloc] init];
        self.carlTermDataSource = [[CarlTermDataSource alloc] init];
        self.faqDataSource = [[FaqDataSource alloc] init];
    }
    return self;
}

// raise an exception
- (id)init {
    [NSException exceptionWithName:@"InvalidOperation" 
                            reason:@"Cannot invoke init on a Singleton class. Use sharedDSManager." 
                          userInfo:nil];
    return nil;
}

#pragma mark ---- Getters

- (EventDataSource *)eventDataSource
{
    if (!_eventDataSource) {
        _eventDataSource = [[EventDataSource alloc] init];
    }
    return _eventDataSource;
}

- (ContactDataSource *)contactDataSource
{
    if (!_contactDataSource) {
        _contactDataSource = [[ContactDataSource alloc] init];
    }
    return _contactDataSource;
}

- (CarlTermDataSource *)carlTermDataSource
{
    if (!_carlTermDataSource) {
        _carlTermDataSource = [[CarlTermDataSource alloc] init];
    }
    return _carlTermDataSource;
}

- (FaqDataSource *)faqDataSource
{
    if (!_faqDataSource) {
        _faqDataSource = [[FaqDataSource alloc] init];
    }
    return _faqDataSource;
}
@end