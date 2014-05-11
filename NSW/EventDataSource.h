//
//  EventDataSource.h
//  NSW
//
//  Created by Stephen Grinich on 5/9/14.
//  Copyright (c) 2014 Stephen Grinich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventDataSource : NSObject

@property NSString *rawEvents;

//NSMutableArray *getEventArrayForDate(NSString *date);

-(void)parseStringFromURL;
-(void)connectionDidFinishLoading;
-(void)connection;
-(void)parseIntoEvents;

@end
