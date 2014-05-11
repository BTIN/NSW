//
//  Contact.m
//  NSW
//
//  Created by Lab User on 5/11/14.
//  Copyright (c) 2014 Stephen Grinich. All rights reserved.
//

#import "Contact.h"

@implementation Contact
@synthesize title;
@synthesize phone;
@synthesize fax;
@synthesize email;


- (id)init {
    self = [super init];
    if (self) {
        // initialization happens here.
    }
    
    return self;
}
@end
