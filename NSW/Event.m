//
//  Event.m
//  NSW
//
//  Created by Alex Simonides on 5/10/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "Event.h"



@implementation Event
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

-(id)initWithTitle:(NSString *)title_ Description:(NSString *)desc_ Location:(NSString *)location_ Start:(NSString *)rawStart Duration:(NSString *)rawDuration
{
    self = [super init];
    if (self) {
        self.title = title_;
        self.theDescription = desc_;
        self.location = location_;
        self.startDateTime = [self parseStartDateTimeFromString:rawStart];
        self.duration = [self parseDurationFromString:rawDuration];
    }
    return self;
}

// This is a built-in function that's called when you try print an Event (like toString() in Java)
-(NSString *) description {
    return [NSString stringWithFormat: @"Event: Title=%@, Description=%@, Location=%@, Start=%@, Duration=%@ seconds.", title, theDescription, location, startDateTime, duration];
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
    NSLog(@"%@", startDateTime);
}

- (NSNumber *) parseDurationFromString:(NSString *)rawDuration {
    // Split a string that looks like "PT##H##M##S" into the array ['P', # of hours, # of minutes, # of seconds, '']
    NSArray *matches = [rawDuration componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"THMS"]];

    NSNumber *hours = matches[1];
    NSNumber *minutes = matches[2];
    NSNumber *seconds = matches[3];
    
    return [NSNumber numberWithInt:([hours intValue] * 3600 + [minutes intValue] * 60 + [seconds intValue])];
    NSLog(@"%@", duration);
}

-(void) setEndDateTime{
    // Use startDateTime and a NSTimeInterval based duration
#warning stub method
}

@end
