//
//  ContactDataSource.h
//  
//
//  Created by Lab User on 5/11/14.
//
//

#import <Foundation/Foundation.h>

@interface ContactDataSource : NSObject
@property NSString *pageSrc;

//NSMutableArray *getEventArrayForDate(NSString *date);

-(void)parseStringFromURL;

-(void)parseIntoContacts;
@end
