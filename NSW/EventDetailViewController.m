//
//  DetailViewController.m
//  NSW
//
//  Created by Stephen Grinich on 5/7/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "EventDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "NSWEvent.h"

@interface EventDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *topContainer;
@property (weak, nonatomic) IBOutlet UIButton *middleContainer;

//@property (weak, nonatomic) IBOutlet UITextView *textDescription;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *eventLocation;
@property (weak, nonatomic) IBOutlet UILabel *startTimeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;

@property int time;
@property BOOL timeChosen;
@property BOOL notificationSet;

@property UILocalNotification *localNotification;
@property NSDate *fireNotification;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleBar;
@property (weak, nonatomic) IBOutlet UITextView *eventDescription;

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
- (IBAction)notifyButton:(id)sender {
    // Right now, notifications will display automatically because the NSW data we're using is from 2012 and that's in the past. Once
    // 2014 NSW data is used, notifications will work properly
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"How far ahead would you like to be notified?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"5 Minutes",
                            @"15 Minutes",
                            @"30 Minutes",
                            @"1 Hour",
                            @"1 Day",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];

    
    self.localNotification = [[UILocalNotification alloc] init];
    self.fireNotification = [self.detailItem startDateTime];
    //self.localNotification.alertBody = self.eventName.text;
    self.localNotification.timeZone = [NSTimeZone defaultTimeZone];

}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        

        [_eventDescription setScrollEnabled:YES];
        _topContainer.layer.borderColor = [UIColor grayColor].CGColor;
        _topContainer.layer.borderWidth = 0.25;
        _topContainer.layer.cornerRadius = 3;
        
        _middleContainer.layer.borderColor = [UIColor grayColor].CGColor;
        _middleContainer.layer.borderWidth = 0.25;
        _middleContainer.layer.cornerRadius = 3;

       
        _eventLocation.text = [self.detailItem location];
        _eventLocation.adjustsFontSizeToFitWidth = YES;
        
        // Convert NSDate to NSString
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

        //NSLocale *twelveHourLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        //dateFormatter.locale = twelveHourLocale;

        
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        // set dat format
        [dateFormatter setDateFormat:@"hh:mm a"];
        
        
        //[dateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss"];
        
        NSString *string = [dateFormatter stringFromDate:[self.detailItem startDateTime]];
        NSDate *startDateTime = [self.detailItem startDateTime];
        
        

        // Remove "NSW: " from event title
        NSString *eventNameString = [self.detailItem title];
        NSString *eventNameStringFirstFourChars = [eventNameString substringToIndex:5];
        if([eventNameStringFirstFourChars  isEqual: @"NSW: "]){
            eventNameString = [eventNameString substringFromIndex:5];
        }
        
        
        _eventName.text = eventNameString;
        _eventName.adjustsFontSizeToFitWidth = YES;
        
        
    
        //_textDescription.text = [self.detailItem theDescription];
        [_eventDescription setText:[self.detailItem theDescription]];
    
        
        
        // Convert NSNumber to NSString for minutes
        NSTimeInterval descriptionNumber = [self.detailItem duration];
        int descriptionInteger = (int) descriptionNumber;
        descriptionInteger = descriptionInteger/60;
        
        
        NSDate* newDate = [startDateTime dateByAddingTimeInterval:descriptionNumber];
        NSString *newDateString = [dateFormatter stringFromDate:newDate];
        NSString *dash = @" – ";
        
        self.startTimeDescriptionLabel.text = [NSString stringWithFormat:@"%@ %@ %@", string, dash, newDateString];
    

        _titleBar.title = eventNameString;
        
        
    
    
    }
}

- (CGFloat)textViewHeightForAttributedText: (NSAttributedString*)text andWidth: (CGFloat)width {
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setAttributedText:text];
    CGSize size = [calculationView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// options presented when selecting a notification time
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Setting a new notification removes previous notification
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    self.notificationSet = NO;
    
    if(buttonIndex == 0){
        
        // 5 minutes before event starts
        self.fireNotification = [self.fireNotification dateByAddingTimeInterval:-300];
        self.localNotification.fireDate = self.fireNotification;
        [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
        self.notificationSet = YES;
        [_notificationButton setTitle:@"Notification Set" forState:UIControlStateNormal]; // To set the title
        [_notificationButton setEnabled:NO]; // To toggle enabled / disabled
    }
    
    if(buttonIndex == 1){
        
        // 15 minutes before event starts
        self.fireNotification = [self.fireNotification dateByAddingTimeInterval:-900];
        self.localNotification.fireDate = self.fireNotification;
        [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
        self.notificationSet = YES;
        [_notificationButton setTitle:@"Notification Set" forState:UIControlStateNormal]; // To set the title
        [_notificationButton setEnabled:NO]; // To toggle enabled / disabled
    }
    
    if(buttonIndex == 2){
        
        // 30 minutes before event starts
        self.fireNotification = [self.fireNotification dateByAddingTimeInterval:-1800];
        self.localNotification.fireDate = self.fireNotification;
        [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
        self.notificationSet = YES;
        [_notificationButton setTitle:@"Notification Set" forState:UIControlStateNormal]; // To set the title
        [_notificationButton setEnabled:NO]; // To toggle enabled / disabled
    }
    
    if(buttonIndex == 3){
        
        // 1 hour before event starts
        self.fireNotification = [self.fireNotification dateByAddingTimeInterval:-3600];
        self.localNotification.fireDate = self.fireNotification;
        [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
        self.notificationSet = YES;
        [_notificationButton setTitle:@"Notification Set" forState:UIControlStateNormal]; // To set the title
        [_notificationButton setEnabled:NO]; // To toggle enabled / disabled
    }
    
    if(buttonIndex == 4){
        
        // 1 day before event starts
        self.fireNotification = [self.fireNotification dateByAddingTimeInterval:-86400];
        self.localNotification.fireDate = self.fireNotification;
        [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
        self.notificationSet = YES;
        [_notificationButton setTitle:@"Notification Set" forState:UIControlStateNormal]; // To set the title
        [_notificationButton setEnabled:NO]; // To toggle enabled / disabled
    }
    
    else{
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        self.notificationSet = NO;


    }
    
   
    
}



@end
