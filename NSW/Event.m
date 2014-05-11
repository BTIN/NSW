//
//  Event.m
//  NSW
//
//  Created by Alex Simonides on 5/10/14.
//  Copyright (c) 2014 Alex Simonides. All rights reserved.
//

#import "Event.h"



@implementation Event
@synthesize title;
@synthesize description;
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

- (void) setStartDateTimeFromString:(NSString *)rawStartDateTime {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil){
        dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss"]; //this is the correct format but I'm not sure if the syntax is right
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-5*3600]]; // US Central time
    }
    
    // Convert raw string to an NSDate.
    startDateTime = [dateFormatter dateFromString:rawStartDateTime];
    NSLog(@"%@", startDateTime);
}

- (void) setDurationFromString:(NSString *)rawDuration {
    // Split a string that looks like "PT##H##M##S" into the array ['P', # of hours, # of minutes, # of seconds, '']
    NSArray *matches = [rawDuration componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"THMS"]];

    NSNumber *hours = matches[1];
    NSNumber *minutes = matches[2];
    NSNumber *seconds = matches[3];
    
    duration = [NSNumber numberWithInt:([hours intValue] * 3600 + [minutes intValue] * 60 + [seconds intValue])];
    NSLog(@"%@", duration);
}

@end
