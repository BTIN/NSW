//
//  DetailViewController.m
//  NSW
//
//  Created by Stephen Grinich on 5/7/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "EventDetailViewController.h"
//#import "NSWEvent.h"

@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *eventLocation;
@property (weak, nonatomic) IBOutlet UITextView *eventDescription;
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;
@property (weak, nonatomic) IBOutlet UILabel *durationDescription;
//@property (weak, nonatomic) IBOutlet UINavigationItem *titleDescriptionLabel;
- (void)configureView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeDescriptionLabel;
@property int time;
@property BOOL timeChosen;
@property BOOL notificationSet;
@end

@implementation EventDetailViewController




#pragma mark - Managing the detail item

- (void)setDetailItem:(NSWEvent *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.eventLocation.text = [self.detailItem location];
        self.eventLocation.adjustsFontSizeToFitWidth = YES;
        
        // Convert NSDate to NSString
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        /**
        NSLocale *twelveHourLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.locale = twelveHourLocale;
        **/
        
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        
        [dateFormatter setDateFormat:@"hh:mm a"];
        
        
        
        
        //[dateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss"];
        
        NSString *string = [dateFormatter stringFromDate:[self.detailItem startDateTime]];
        NSDate *startDateTime = [self.detailItem startDateTime];
        
        
        // handle description
       // self.eventDescription.adjustsFontSizeToFitWidth = YES;
        [self.eventDescription sizeToFit];
        
        // Remove "NSW: " from event title
        NSString *eventNameString = [self.detailItem title];
        NSString *eventNameStringFirstFourChars = [eventNameString substringToIndex:5];
        if([eventNameStringFirstFourChars  isEqual: @"NSW: "]){
            eventNameString = [eventNameString substringFromIndex:5];
        }
        
        
        self.eventName.text = eventNameString;
        self.eventName.adjustsFontSizeToFitWidth = YES;
        
        
    
        self.eventDescription.text = [self.detailItem theDescription];
        
        
        
        
        // Convert NSNumber to NSString for minutes
        NSTimeInterval descriptionNumber = [self.detailItem duration];
        int descriptionInteger = (int) descriptionNumber;
        descriptionInteger = descriptionInteger/60;
        
        
        NSDate* newDate = [startDateTime dateByAddingTimeInterval:descriptionNumber];
        NSString *newDateString = [dateFormatter stringFromDate:newDate];
        NSString *dash = @" – ";
        
        self.startTimeDescriptionLabel.text = [NSString stringWithFormat:@"%@ %@ %@", string, dash, newDateString];
    
        
        
        
        
        
        /**
        
        NSMutableString *descriptionString = [NSMutableString stringWithFormat:@"%d",descriptionInteger];
        [descriptionString appendString:@" minutes"];
        self.durationDescription.text = descriptionString;
         
         **/
        
        
        
        
        
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //[_eventDescription setUserInteractionEnabled:NO];
    _eventDescription.editable = NO;
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)notificationButton:(id)sender {
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"How far ahead would you like to be notified?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"5 Minutes",
                            @"15 Minutes",
                            @"30 Minutes",
                            @"1 Hour",
                            @"1 Day",
                            nil];
    //popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
    
    
    // try chaning to while
    if(self.timeChosen == YES){
    
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    //localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    
    NSDate *fireNotification = [self.detailItem startDateTime];
        
    // Notification set to 30 minutes before event. Right now it will fire off a notification automatically because
    // we're using the 2012 NSW data and that's all in the past
        
    fireNotification = [fireNotification dateByAddingTimeInterval:self.time];
    localNotification.fireDate = fireNotification;

    localNotification.alertBody = self.eventName.text;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
    self.timeChosen = NO;
        
    }
    

}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // This will remove previous notification whenever a new one is set, or cancelled
    
    
    /**
       TODO:   NOT WORKING RIGHT NOW
     **/
    self.timeChosen = NO;
    
    if(popup.tag == 0){
        self.time = -300;
        self.timeChosen = YES;
    }
    
    else if(popup.tag == 1){
        self.time = -900;
        self.timeChosen = YES;
    }
    
    else if(popup.tag == 2){
        self.time = -1800;
        self.timeChosen = YES;
    }
    
    else if(popup.tag == 3){
        self.time = -3600;
        self.timeChosen = YES;
    }
    
    else if(popup.tag == 4){
        self.time = -86400;
        self.timeChosen = YES;
    }
    
    else{
        self.timeChosen = NO;
    }
    
}



@end
