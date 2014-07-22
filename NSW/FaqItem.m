//
//  FaqItem.m
//  NSW
//
//  Created by Stephen Grinich on 7/21/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "FaqItem.h"

@implementation FaqItem

@synthesize question;
@synthesize answer;

- (id)init {
    self = [super init];
    if (self) {
        // initialization happens here.
    }
    
    return self;
}


- (id)initWithQuestion:(NSString *)faqQuestion
              Answer:(NSString *)faqAnswer{
    self = [super init];
    if (self) {
        self.question = faqQuestion;
        self.answer = faqAnswer;
    }
    
    return self;
}



@end
