//
// Created by Alex Simonides on 5/15/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "BaseNSWDataSource.h"


@implementation BaseNSWDataSource

@synthesize receivedData;

- (id)initWithVCBackref:(BaseNSWTableViewController *)tableViewController
         AndDataFromURL:(NSString *) sourceURL {
    self = [super init];
    
    if (self) {
        myTableViewController = tableViewController;
        //TODO Pseudocode
        //If (self.localData doesn't exist) OR (self.localData.dateModified earlier than 24-hours-before-now)
            //Download from url to local
        //At this point, localData should exist, so load from that 
        [self getRawDataFromURL:sourceURL];
    }

    return self;
}

- (void)getRawDataFromURL:(NSString *)sourceURL {

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    // Create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:sourceURL]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];


    // Create the NSMutableData to hold the received data.
    // receivedData is an instance variable declared elsewhere.
    receivedData = [NSMutableData dataWithCapacity: 0];

    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];


    if (!theConnection) {
        // Release the receivedData object.
        receivedData = nil;
        // Inform the user that the connection failed.
        NSLog(@"Connection failed");

    }

}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data {
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];

}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    //Override in subclasses
}

/* Convenience/readability wrapper for a very unwieldily-named function
 * Which splits a string between any of the characters listed in splitCharacters
 */
+ (NSArray *)splitString:(NSString *)wholeString atCharactersInString:(NSString *)splitCharacters{
    return [wholeString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:splitCharacters]];
}

- (void) cacheEvents{
    //TODO(Alex) Implement caching events to the file system
}

@end