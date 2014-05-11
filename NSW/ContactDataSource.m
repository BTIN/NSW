//
//  ContactDataSource.m
//  
//
//  Created by Lab User on 5/11/14.
//
//

#import "ContactDataSource.h"
#import "Contact.h"
@implementation ContactDataSource
//String of all events
@synthesize pageSrc;

// NSMutableArray * eventList = [NSMutableArray alloc];

NSMutableData *receivedData;
NSArray * parsedContacts;




- (void) parseStringFromURL {
    
    // Create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://apps.carleton.edu/newstudents/contact/"]
                              
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
    self.pageSrc = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    self.parseIntoContacts;
    
}

- (void) parseIntoContacts {
    
    parsedContacts = [[NSArray alloc]init];
    
    
    /* get the chunk of html code that contains contact info
        add each 'contact' chunk into a temporary list, cList */
    NSString *bananas = self.pageSrc;
    NSString *separatorString = @"</main>";
    NSScanner *aScanner = [NSScanner scannerWithString:bananas];
    NSString *container;
    [aScanner scanUpToString:separatorString intoString:&container];
    NSMutableArray *cList;
    cList = [container componentsSeparatedByString:@"<p"];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)];
    [cList removeObjectsAtIndexes:indexSet];
    

    
    
    /* loop through parse each each section of HTML into a new Contact
        add each instance created into global parsedContacts variable
     */
    for (id obj in cList){
        
        //create reference to an uninstantiated Conact
        //Contact c = [Contact alloc] init]];
        
        //find the title for current Contact
        NSString * title;
        NSString* beforeStrong;
        NSScanner *scanner = [NSScanner scannerWithString:obj];
        [scanner scanUpToString:@"</strong>" intoString:&beforeStrong];
        if (!([beforeStrong rangeOfString:@"<strong>"].location == NSNotFound)){
            NSRange range = [beforeStrong rangeOfString:@"<strong>"];
            title = [[beforeStrong substringFromIndex:range.location] substringFromIndex:8];
            title = [title stringByReplacingOccurrencesOfString:@"&amp;"
                                                         withString:@"and"];
            title = [title stringByReplacingOccurrencesOfString:@"<br />"
                                                     withString:@""];
        }
        
        
        //find the phone number for the current Contact
        NSString * phone;

        

        
        
        
        
        
        
    }
    
    
}


@end
