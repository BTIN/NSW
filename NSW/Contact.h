//
//  Contact.h
//  NSW
//
//  Created by Lab User on 5/11/14.
//  Copyright (c) 2014 Stephen Grinich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *fax;
@property (nonatomic, strong) NSString *email;

- (id)initWithTitle:(NSString *)contactName Phone:(NSString *)phoneNumber Fax:(NSString *)faxNumber  Email:(NSString *)emailAddress;
@end
