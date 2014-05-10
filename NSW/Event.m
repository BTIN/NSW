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
@synthesize startDT;
@synthesize duration;

- (id)init {
    self = [super init];
    if (self) {
        // initialization happens here.
    }
    
    return self;
}

- (void) setStartDTFromString:(NSString *)rawStartDT {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil){
        dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setDateFormat:@"yyyymmdd'T'hhmmss"]; //this is the correct format but I'm not sure if the syntax is right
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-5*3600]]; // US Central time
    }
    
    // Convert raw string to an NSDate.
    startDT = [dateFormatter dateFromString:rawStartDT];
}

- (void) setdurationFromString:(NSString *)rawDuration {
    NSString *durationPattern = @"PT(\\d{1,2})H(\\d{1,2})S(\\d{1,2})";
    
    NSRegularExpression *durationRE = [NSRegularExpression regularExpressionWithPattern:durationPattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *matches = [durationRE matchesInString:rawDuration options:0 range:NSMakeRange(0, [rawDuration length])];
    
    NSNumber *hours = [matches objectAtIndex:0];
    NSNumber *minutes = [matches objectAtIndex:1];
    NSNumber *seconds = [matches objectAtIndex:2];
    
    duration = [NSNumber numberWithInt:([hours intValue] * 3600 + [minutes intValue] * 60 + [seconds intValue])];
}

@end
