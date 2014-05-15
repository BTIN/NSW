//
//  NSWEvent.m
//  NSW
//
//  Created by Alex Simonides on 5/10/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "NSWEvent.h"



@implementation NSWEvent
@synthesize calendarID;
@synthesize title;
@synthesize theDescription;
@synthesize location;
@synthesize startDateTime;
@synthesize duration;

- (id)init {
    self = [super init];
    if (self) {
        // initialization happens here.
    }
    
    return self;
}

-(id)initWithID:(NSString *) id_ Title:(NSString *)title_ Description:(NSString *)desc_ Location:(NSString *)location_ Start:(NSString *)rawStart Duration:(NSString *)rawDuration
{
    self = [super init];
    if (self) {
        self.calendarID = id_;
        self.title = title_;
        self.theDescription = desc_;
        self.location = location_;
        self.startDateTime = [self parseStartDateTimeFromString:rawStart];
        self.duration = [self parseDurationFromString:rawDuration];
    }
    return self;
}

// This is a built-in function that's called when you try print an NSWEvent (like toString() in Java)
-(NSString *) description {
    return [NSString stringWithFormat: @"NSWEvent: Title=%@, Description=%@, Location=%@, Start=%@, Duration=%f seconds.",
                    title, theDescription, location, startDateTime, duration];
}


// Takes a start time string in the ICS format and translates it into an NSDate object
- (NSDate *) parseStartDateTimeFromString:(NSString *)rawStartDateTime {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil){
        dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss"]; //this is the correct format but I'm not sure if the syntax is right
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-5*3600]]; // US Central time
    }
    
    // Convert raw string to an NSDate.
    return [dateFormatter dateFromString:rawStartDateTime];
}

- (double) parseDurationFromString:(NSString *)rawDuration {
    // Split a string that looks like "PT##H##M##S" into the array ['P', # of hours, # of minutes, # of seconds, '']
    NSArray *matches = [NSWEvent splitString:rawDuration atCharactersInString:@"THMS"];

    NSNumber *hours = matches[1];
    NSNumber *minutes = matches[2];
    NSNumber *seconds = matches[3];

    return ([hours doubleValue] * 3600 + [minutes doubleValue] * 60 + [seconds doubleValue]);
}

/* Convenience/readability wrapper for a very unwieldily-named function
 * Which splits a string between any of the characters listed in splitCharacters
 */
+ (NSArray *)splitString:(NSString *)wholeString atCharactersInString:(NSString *)splitCharacters{
    return [wholeString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:splitCharacters]];
}


-(NSDate *) getEndDateTime{
    return [NSDate dateWithTimeInterval:duration sinceDate:startDateTime];
}


@end
