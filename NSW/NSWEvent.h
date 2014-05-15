//
//  NSWEvent.h
//  NSW
//
//  Created by Alex Simonides on 5/10/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSWEvent : NSObject

@property (nonatomic, strong) NSString *calendarID; // Unique ID that could be useful
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *theDescription;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSDate *startDateTime; // a NSDate object representing the start date and time of the event
@property (nonatomic) NSTimeInterval duration; // The number of seconds that the event lasts
//@property (nonatomic, strong) NSDate *endDateTime;

-(id)initWithID:(NSString *) id_ Title:(NSString *)title_ Description:(NSString *)desc_ Location:(NSString *)location_ Start:(NSString *)rawStart Duration:(NSString *)rawDuration;
//-(NSDate *) parseStartDateTimeFromString:(NSString *)rawStartDateTime;
//-(NSNumber *) parseDurationFromString:(NSString *)rawDuration;
+ (NSArray *)splitString:(NSString *)wholeString atCharactersInString:(NSString *)splitCharacters;
@end
