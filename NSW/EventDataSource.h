//
//  EventDataSource.h
//  NSW
//
//  Created by Stephen Grinich on 5/9/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventDataSource : NSObject

@property NSString *rawEvents;
@property NSArray *allParsedEvents;


//NSMutableArray *getEventArrayForDate(NSString *date);

-(void)parseStringFromURL;
-(void)parseIntoEvents;
-(void)connectionDidFinishLoading:(NSURLConnection *)connection;
-(void)returnArray;

@end
