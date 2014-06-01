//
// Created by Alex Simonides on 5/15/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "BaseNSWDataSource.h"
#import "FLDownloader.h"
#import "EventListViewController.h"

@interface BaseNSWDataSource ()
@property (nonatomic, strong) NSDictionary *urlMap;
@end

@implementation BaseNSWDataSource

static NSString *genericLocalFilePath;
static BOOL dataIsReady;
@synthesize localData;
@synthesize dataList;

// Maps what URL corresponds to which local file name
- (id)urlMap {
    if (!_urlMap) {
        NSArray *fileNames = @[@"events.ics", @"contacts.html", @"terms.json"];
        NSArray *urls = @[[NSURL URLWithString:@"https://apps.carleton.edu/newstudents/events/?start_date=2012-09-01&format=ical"],
                [NSURL URLWithString:@"https://apps.carleton.edu/newstudents/contact/"],
                [NSURL URLWithString:@"http://harrise.github.io/terms.json"]];
        _urlMap = [NSDictionary dictionaryWithObjects:urls forKeys:fileNames];
        if (_urlMap.count != urls.count) {
            NSLog(@"Have %d URLs, but have %d entries in urlMap", urls.count, _urlMap.count);
        }
    }
    return _urlMap;
}


- (id)initPrivate {
    self.downloadStarted = [NSDate date];
    dataIsReady = NO;
    return [super init];
}

// Load the given file from the local storage location
- (id)initWithVCBackref:(BaseNSWTableViewController *)tableViewController
        AndDataFromFile:(NSString *)localName {
    self = [self initPrivate];

    if (self) {
        myTableViewController = tableViewController;
        [self getLocalFile:localName
         orDownloadFromURL:[self.urlMap objectForKey:localName]];
    }

    return self;
}

- (id)initWithDataFromFile:(NSString *)localName {
    self = [self initPrivate];

    if (self) {
        myTableViewController = nil;
        NSURL *remoteURL = [self.urlMap objectForKey:localName];
        [self getLocalFile:localName orDownloadFromURL:remoteURL];
    }

    return self;
}

// Attaches a TableViewController to send the data to once it has been loaded
- (void)attachVCBackref:(BaseNSWTableViewController *)tableViewController {
    myTableViewController = tableViewController;
    
    // If data is ready, send it to tableViewController. Otherwise the data is still 
    // being retrieved and will be sent when it's ready.
    if (dataIsReady) {
        // EventListViewController only wants the list for today
        if ([tableViewController isKindOfClass:[EventListViewController class]]) {
            [(EventListViewController *) myTableViewController getEventsFromCurrentDate];
        } else {
            [myTableViewController setVCArrayToDataSourceArray:self.dataList];
        }
    } else {
        NSLog(@"Data is still being retrieved.");
    }
}

// Create the directory that the data files will be stored in 
// if it hasn't already been created
- (void)createLocalDataDirectoryIfNoneExists {
    genericLocalFilePath = [[[FLDownloader sharedDownloader] defaultFilePath] stringByAppendingPathComponent:@"LocalData"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir;
    BOOL locationExists = [fileManager fileExistsAtPath:genericLocalFilePath 
                                            isDirectory:&isDir];
    // isDir will be changed to whether the genericLocalFilePath is a directory. 
    // It's how the existence function is able to "return" 2 values
    if (!locationExists)
    {
        NSError *error;
        [fileManager createDirectoryAtPath:genericLocalFilePath 
               withIntermediateDirectories:NO 
                                attributes:nil 
                                     error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
    } else if (!isDir) {
        NSLog(@"%@ exists but isn't a directory", genericLocalFilePath);
    }
}

// If the file exists locally, load it into self.localData (using getRawDataFromURL)
// Otherwise, download it to local storage THEN load it into self.localData
- (void)getLocalFile:(NSString *)fileName orDownloadFromURL:(NSURL *)URL {
    [self createLocalDataDirectoryIfNoneExists];
    NSString *pathToLocalFile = [genericLocalFilePath stringByAppendingPathComponent:fileName];
    
    //A block to "download" the data file from the file system into self.localData
    void (^onCompletion)(BOOL, NSError *) = ^(BOOL success, NSError *error) {
        if (success) {
            [self getRawDataFromURL:[NSURL fileURLWithPath:pathToLocalFile]];
        } else {
            NSLog(@"Error downloading %@: %@", fileName, error);
        }
    };
    
    //Set up a FLDownloadTask to download the source from the URL, but don't start yet
    FLDownloadTask *downloadTask = [[FLDownloader sharedDownloader] downloadTaskForURL:URL];
    [downloadTask setFileName:fileName];
    [downloadTask setDestinationDirectory:genericLocalFilePath];
    [downloadTask setCompletionBlock:onCompletion];

    if ([[NSFileManager defaultManager] fileExistsAtPath:pathToLocalFile]){
        onCompletion(YES, nil);
        //TODO check how old the local data is, Then reload if more than a day
    } else {
        // Logs the progress of the the download
        [downloadTask setProgressBlock:^(NSURL *url, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite)
                {
                    float progress = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
                    NSLog(@"%@ Progress: %.2f", fileName, progress);
                }];
        [downloadTask start];
    }
    
}

- (void)getRawDataFromURL:(NSURL *)sourceURL {
    
    // Allow the network activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    // Create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:sourceURL
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];


    // Create the NSMutableData to hold the received data.
    // localData is an instance variable declared elsewhere.
    localData = [NSMutableData dataWithCapacity: 0];
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];


    if (!theConnection) {
        // Release the localData object.
        localData = nil;
        // Inform the user that the connection failed.
        NSLog(@"Connection failed");

    }

}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data {
    // Append the new data to localData.
    // localData is an instance variable declared elsewhere.
    [localData appendData:data];

}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    //Override in subclasses
}

// Log how long it took to retrieve the download
- (void)logDownloadTime {
    dataIsReady = YES;
    NSDate *downloadFinished = [NSDate date];
    NSLog(@"Download took %.6f seconds", [downloadFinished timeIntervalSinceDate:self.downloadStarted]);
}

/* Convenience/readability wrapper for a very unwieldily-named function
 * Which splits a string between any of the characters listed in splitCharacters
 */
+ (NSArray *)splitString:(NSString *)wholeString atCharactersInString:(NSString *)splitCharacters{
    return [wholeString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:splitCharacters]];
}

@end