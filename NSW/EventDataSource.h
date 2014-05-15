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
//@property NSString *rawICSString;
//@property NSArray *splitEventStrings;
@property NSMutableArray *fullEventList;

//NSMutableArray *getEventArrayForDate(NSString *date);
-(id)initWithVCBackref:(EventListViewController *) eventListViewController;
-(void)getRawDataFromURL;
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection;
//-(void)returnArray;

@end
