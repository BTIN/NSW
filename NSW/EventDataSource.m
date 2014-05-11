//
//  EventDataSource.m
//  NSW
//
//  Created by Stephen Grinich on 5/9/14.
//  Copyright (c) 2014 Stephen Grinich. All rights reserved.
//

#import "EventDataSource.h"


@implementation EventDataSource

//String of all events
@synthesize rawEvents;
@synthesize allParsedEvents;

// NSMutableArray * eventList = [NSMutableArray alloc];

NSMutableData *receivedData;
bool done;



- (void) parseStringFromURL {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://apps.carleton.edu/newstudents/events/?start_date=2012-09-01&format=ical"]
                              
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



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
    
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // This ASCII is weird. Other things give us Chinese. What do we do?
    self.rawEvents = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    [self parseIntoEvents];
    
    
    
}

- (void) parseIntoEvents {
    
    self.allParsedEvents = [[NSArray alloc]init];
    self.allParsedEvents = [self.rawEvents componentsSeparatedByString:@"BEGIN:VEVENT"];
    //NSLog(@"%@", allParsedEvents[1]);
    
    done = YES;
    
    NSLog(@"test 2");
    
    
}

- (void) returnArray{
    [self parseStringFromURL];
    if (done) {
        NSLog(@"%@", self.allParsedEvents[1]);
    }
    
    NSLog(@"test");

   
    
}




@end
