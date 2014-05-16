//
// Created by Alex Simonides on 5/16/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "NSWConstants.h"


@implementation NSWConstants {

}

+ (NSTimeZone *)northfieldTimeZone {
    return [NSTimeZone timeZoneForSecondsFromGMT: -5 * secondsPerHour];
}

+ (NSTimeInterval)yesterday {
    return -1 * secondsPerDay;
}

+ (NSTimeInterval)tomorrow {
    return secondsPerDay;
}


@end