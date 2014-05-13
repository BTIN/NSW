//
//  ContactDataSource.h
//  
//
//  Created by Evan Harris on 5/11/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactDataSource : NSObject
@property NSString *pageSrc;

//NSMutableArray *getEventArrayForDate(NSString *date);

-(void)parseStringFromURL;

-(void)parseIntoContacts;
@end
