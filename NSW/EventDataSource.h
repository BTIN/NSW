//
//  EventDataSource.h
//  NSW
//
//  Created by Stephen Grinich on 5/9/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventListViewController.h"

@interface EventDataSource : NSObject {
    __weak EventListViewController *eventListVC;
}

//@property NSString *icsHeader;
@property NSMutableArray *fullEventList;

//NSMutableArray *getEventArrayForDate(NSString *date);
-(id)initWithVCBackref:(EventListViewController *) eventListViewController;

+ (NSArray *)splitString:(NSString *)wholeString atCharactersInString:(NSString *)splitCharacters;

-(void)getRawDataFromURL;

@end
