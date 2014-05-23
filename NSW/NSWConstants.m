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


@end