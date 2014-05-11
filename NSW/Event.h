//
//  Event.h
//  NSW
//
//  Created by Alex Simonides on 5/10/14.
//  Copyright (c) 2014 Alex Simonides. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSDate *startDateTime;
@property (nonatomic, strong) NSNumber *duration;

-(void) setStartDateTimeFromString:(NSString *)rawStartDateTime;
-(void) setDurationFromString:(NSString *)rawDuration;

@end
