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
    // pattern for regular expression
    NSString *durationPattern = @"PT(\\d{1,2})H(\\d{1,2})S(\\d{1,2})";
    
    // create regular expression from pattern
    NSRegularExpression *durationRE = [NSRegularExpression regularExpressionWithPattern:durationPattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *matches = [durationRE matchesInString:rawDuration options:0 range:NSMakeRange(0, [rawDuration length])];
    NSLog(@"%@", matches);
    NSNumber *hours = [matches objectAtIndex:0];
    NSNumber *minutes = [matches objectAtIndex:1];
    NSNumber *seconds = [matches objectAtIndex:2];
    
    duration = [NSNumber numberWithInt:([hours intValue] * 3600 + [minutes intValue] * 60 + [seconds intValue])];
    NSLog(@"%@", duration);
}

@end
