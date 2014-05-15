//
//  EventDataSource.m
//  NSW
//
//  Created by Stephen Grinich on 5/9/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "EventDataSource.h"
#import "NSWEvent.h"


@implementation EventDataSource

//@synthesize icsHeader;
//String of all events
//@synthesize rawICSString;
//@synthesize splitEventStrings;
@synthesize fullEventList;

// NSMutableArray * eventList = [NSMutableArray alloc];

NSMutableData *receivedData;
bool done;

- (id)initWithVCBackref:(EventListViewController *) eventListViewController{
    self = [super init];
    if (self) {
        eventListVC = eventListViewController;
        [self getRawDataFromURL];//@"https://apps.carleton.edu/newstudents/events/?start_date=2012-09-01&format=ical"];
    }

    return self;
}

// TODO (Alex) This is probably a method we want in all DataSource classes, we may want to sanitize it and create a DataSource superclass
- (void)getRawDataFromURL{//:(NSString *) dataURL{
    
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
    
    // This ASCII can't handle the typographical apostrophe. Unicode gives us Chinese, UTF-8 gives us nil. What do we do?
    NSString *rawICSString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding]; //NSUTF8StringEncoding];

    NSArray *splitEventStrings = [rawICSString componentsSeparatedByString:@"BEGIN:VEVENT"];

    //NSLog(@"%@", splitEventStrings[1]);

    self.fullEventList = [[NSMutableArray alloc] init];
    for (NSUInteger i = 1; i < splitEventStrings.count-1; i++) {
        NSWEvent *currentEvent = [self parseEventFromString:splitEventStrings[i]];
        [self.fullEventList addObject:currentEvent];
    }
    [eventListVC getEventListFromDataSource:self.fullEventList];

}

/* Builds a NSWEvent from a given ics-formatted event
example ICS event:
    UID:20100804115306-653193@carleton.edu
    SUMMARY:NSW Parent Information Session: The First Year at Carleton
    DESCRIPTION:The beginning of a college career brings momentous transitions to students
    and their families. At this session, staff and faculty will describe the va
    rious resources for guidance and assistance available to Carleton students
    and make some suggestions about parents’ roles in a liberal arts educatio
    n.
    LOCATION:Concert Hall
    LAST-MODIFIED:20120726T151934
    CREATED:20100804T115306
    DTSTART:20120904T150000
    DURATION:PT0H45M0S
    END:VEVENT
*/
- (NSWEvent *)parseEventFromString:(NSString *) icsFormattedEvent {
    //First break the string into lines
    NSArray *lines = [icsFormattedEvent componentsSeparatedByString:@"\r\n"];

    NSString *id_ = [self parseID:lines[1]];
    NSMutableString *title_ = [[self parseSimpleAttribute:lines[2]] mutableCopy];
    NSMutableString *desc_;

    NSString *loc_;
    NSString *start_;
    NSString *dur_;


    BOOL inTitle = YES;
    BOOL inDescription = NO;
    //We can confidently assume the first two lines, (and usually the third, but not always) but beyond those the
    // description lasts an arbitrary number of lines and there are optional attributes that prevent us from reverse-indexing
    for (NSUInteger i = 3; i < lines.count-1; i++) {
        NSString *currentLine = lines[i];

        // Descriptions and titles longer than 76 characters are more than one line and have a blank
        // space at the beginning of subsequent lines to indent them slightly
        if ([currentLine hasPrefix:@" "]) {
            if (inDescription) {
                [desc_ appendString: [currentLine substringFromIndex:1]];
            }
            // Almost no titles are this long, but there are some
            else if (inTitle){
                [title_ appendString: [currentLine substringFromIndex:1]];
            }
        }

        else {
            inTitle = NO;
            inDescription = NO;
            NSArray *splitLine = [currentLine componentsSeparatedByString:@":"];
            NSString *attributeTitle = splitLine[0];

            if ([attributeTitle isEqual:@"DESCRIPTION"]) {
                desc_ = [splitLine[1] mutableCopy];
                inDescription = YES;
            }
            else if ([attributeTitle isEqual:@"LOCATION"]){
                loc_ = splitLine[1];
            }
            else if ([attributeTitle isEqual:@"DTSTART"]){
                start_ = splitLine[1];
            }
            else if ([attributeTitle isEqual:@"DURATION"]){
                dur_ = splitLine[1];
            }
        }
    }

    NSWEvent *test = [[NSWEvent alloc] initWithID:id_
                                  Title:title_
                            Description:desc_
                               Location:loc_
                                  Start:start_
                               Duration:dur_];
    return test;
}

- (NSString *)parseID:(NSString *) idLine{
    NSArray *lineComponents = [NSWEvent splitString:idLine atCharactersInString:@"-@"];
    //The unique ID is the part between the "-" and the "@"
    return lineComponents[1];
}

// Most of the attributes are of the form "ATTRIBUTENAME:data-we-care-about"
- (NSString *)parseSimpleAttribute:(NSString *) fullLine{
    NSMutableArray *lineComponents = (NSMutableArray *) [fullLine componentsSeparatedByString:@":"];

    if (lineComponents.count == 2){
        return lineComponents[1];
    }
    else {
        // Remove the attribute title then put back any other :s we removed
        [lineComponents removeObjectAtIndex:0];
        return [lineComponents componentsJoinedByString:@":"];
    }
}


/*
- (void) returnArray{
    [self getRawDataFromURL];
    if (done) {
        NSLog(@"%@", self.fullEventList[0]);
    }
    
    NSLog(@"test");
    
}
*/

- (void) cacheEvents{
    //TODO(Alex) Implement caching events to the file system
}




@end
