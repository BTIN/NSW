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


- (void)configureView
{
    
    // Update the user interface for the detail item.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    

    if (self.detailItem) {
        

        _topContainer.layer.borderColor = [UIColor grayColor].CGColor;
        _topContainer.layer.borderWidth = 0.25;
        _topContainer.layer.cornerRadius = 15;
        
        
        [_eventDescription setScrollEnabled:YES];
        _eventDescription.layer.borderColor = [UIColor grayColor].CGColor;
        _eventDescription.layer.borderWidth = 0.25;
        _eventDescription.layer.cornerRadius = 15;
        [_eventDescription setTextContainerInset:UIEdgeInsetsMake(8, 10, 8, 10)]; // top, left, bottom, right
        _eventLocation.text = [self.detailItem location];
        
        
    
        // Convert NSDate to NSString
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

        //NSLocale *twelveHourLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        //dateFormatter.locale = twelveHourLocale;

        
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        // set date format
        [dateFormatter setDateFormat:@"hh:mm a"];
        
        
        //[dateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss"];
        
        NSString *startDateTimeString = [dateFormatter stringFromDate:[self.detailItem startDateTime]];
        NSDate *startDateTime = [self.detailItem startDateTime];
        NSDate *endDateTime = [self.detailItem endDateTime];
        
        // Remove "NSW: " from event title
        NSString *eventNameString = [self.detailItem title];
        NSString *eventNameStringFirstFourChars = [eventNameString substringToIndex:5];
        if([eventNameStringFirstFourChars  isEqual: @"NSW: "]){
            eventNameString = [eventNameString substringFromIndex:5];
        }
        
        _eventName.text = eventNameString;
        //_eventName.adjustsFontSizeToFitWidth = YES;
    
        //_textDescription.text = [self.detailItem theDescription];
        [_eventDescription setText:[self.detailItem theDescription]];
        
        // Convert NSNumber to NSString for minutes
        NSTimeInterval descriptionNumber = [self.detailItem duration];
        int descriptionInteger = (int) descriptionNumber;
        descriptionInteger = descriptionInteger/60;
        
        
        NSDate* newDate = [startDateTime dateByAddingTimeInterval:descriptionNumber];
        NSString *newDateString = [dateFormatter stringFromDate:newDate];
        NSString *dash = @" – ";
        
        
        // Turns "08:00am" to "8:00am"
        if(![startDateTime isEqualToDate:endDateTime]){
            
            if ([startDateTimeString hasPrefix:@"0"]) {
                startDateTimeString = [startDateTimeString substringFromIndex:1];
            }
            
            if ([newDateString hasPrefix:@"0"]) {
                newDateString = [newDateString substringFromIndex:1];
            }
            
            
            
            self.startTimeDescriptionLabel.text = [NSString stringWithFormat:@"%@ %@ %@", startDateTimeString, dash, newDateString];
        }
        
        else{
            
            self.startTimeDescriptionLabel.text = [dateFormatter stringFromDate:startDateTime];
            
            if ([self.startTimeDescriptionLabel.text hasPrefix:@"0"]) {
                self.startTimeDescriptionLabel.text = [self.startTimeDescriptionLabel.text substringFromIndex:1];
            }
        }
        

        _titleBar.title = @"Event";
        
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
        
    self.wantsFullScreenLayout = YES;
    
	// Do any additional setup after loading the view, typically from a nib.
    
    [self configureView];
}


-(IBAction)doneButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)notifyButton:(id)sender {
    // Right now, notifications will display automatically because the NSW data we're using is from 2012 and that's in the past. Once
    // 2014 NSW data is used, notifications will work properly
    
    
    
    // get day of event
    // if day of event is in pass, don't allow notification to be pressed
    // popup box saying 'that's already happened'
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"MMMM d"];
    NSString *startDateTimeString = [dateFormatter stringFromDate:[self.detailItem startDateTime]];
    NSLog(startDateTimeString);
    
    
    
    NSDate *now = [NSDate date];
    NSDate *startDateTime = [self.detailItem startDateTime];
    
    
    if([now compare:startDateTime] ==  NSOrderedAscending){
        
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
        self.localNotification.timeZone = [NSTimeZone defaultTimeZone];
    }
    
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                        message:@"This event has already happened."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

    
    
    
    
}

// Options presented when selecting a notification time
    // Selecting a time in the past will display the notification immediately. Test by setting date of device to
    // corresponding date of event in 2012
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    
    NSDate *now = [NSDate date];
    NSDate *startDateTime = [self.detailItem startDateTime];
    
    
    if(buttonIndex == 0){
        
        // 5 minutes before event starts
        NSTimeInterval secondsInFiveMinutes =  -5 * 60;
        NSDate *dateFiveMinutesBehind = [startDateTime dateByAddingTimeInterval:secondsInFiveMinutes];
        
        if([now compare:dateFiveMinutesBehind] ==  NSOrderedAscending){
        
            self.localNotification.alertBody = [NSString stringWithFormat:@"%@%@", self.eventName.text,@" is in 5 minutes"];
            self.localNotification.fireDate = [[self.detailItem startDateTime] dateByAddingTimeInterval:-300];
            [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
            [_notificationButton setEnabled:NO]; // To toggle enabled / disabled
            
        }
        
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                            message:@"It's too clsoe to this event right now to be reminded that early."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
       
        
    }
    
    if(buttonIndex == 1){
        
        // 15 minutes before event starts
        NSTimeInterval secondsInFifteenMinutes =  -15 * 60;
        NSDate *dateFifteenMinutesBehind = [startDateTime dateByAddingTimeInterval:secondsInFifteenMinutes];

        
        if([now compare:dateFifteenMinutesBehind] ==  NSOrderedAscending){
        
            self.localNotification.alertBody = [NSString stringWithFormat:@"%@%@", self.eventName.text,@" is in 15 minutes."];
            self.localNotification.fireDate = [[self.detailItem startDateTime] dateByAddingTimeInterval:-900];
            [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
            [_notificationButton setEnabled:NO]; // To toggle enabled / disabled
        }
        
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                            message:@"It's too clsoe to this event right now to be reminded that early."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        
    }
    
    if(buttonIndex == 2){
        
        // 30 minutes before event starts
        NSTimeInterval secondsInThirtyMinutes =  -30 * 60;
        NSDate *dateThirtyMinutesBehind = [startDateTime dateByAddingTimeInterval:secondsInThirtyMinutes];
        
        if([now compare:dateThirtyMinutesBehind] ==  NSOrderedAscending){
        
            self.localNotification.alertBody = [NSString stringWithFormat:@"%@%@", self.eventName.text,@" is in 30 minutes."];
            self.localNotification.fireDate = [[self.detailItem startDateTime] dateByAddingTimeInterval:-1800];
            [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
            [_notificationButton setEnabled:NO]; // To toggle enabled / disable
        }
        
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                            message:@"It's too clsoe to this event right now to be reminded that early."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        
    }
    
    if(buttonIndex == 3){
        
        // 1 hour before event starts
        NSTimeInterval secondsInOneHour =  -60 * 60;
        NSDate *dateOneHourBehind = [startDateTime dateByAddingTimeInterval:secondsInOneHour];
        
        if([now compare:dateOneHourBehind] ==  NSOrderedAscending){

            self.localNotification.alertBody = [NSString stringWithFormat:@"%@%@", self.eventName.text,@" is in 1 hour."];
            self.localNotification.fireDate = [[self.detailItem startDateTime] dateByAddingTimeInterval:-3600];
            [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
            [_notificationButton setEnabled:NO]; // To toggle enabled / disabled
        }
        
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                            message:@"It's too clsoe to this event right now to be reminded that early."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        
    }
    
    if(buttonIndex == 4){
        
        // 1 day before event starts
        NSTimeInterval secondsInOneDay =  -1440 * 60;
        NSDate *dateOneDayBehind = [startDateTime dateByAddingTimeInterval:secondsInOneDay];
        
        if([now compare:dateOneDayBehind] ==  NSOrderedAscending){
            self.localNotification.alertBody = [NSString stringWithFormat:@"%@%@", self.eventName.text,@" is tomorrow."];
            self.localNotification.fireDate = [[self.detailItem startDateTime] dateByAddingTimeInterval:-86400];
            [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
            [_notificationButton setEnabled:NO]; // To toggle enabled / disabled
        }
        
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                            message:@"It's too clsoe to this event right now to be reminded that early."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        
    }
    
    else{
        //[[UIApplication sharedApplication] cancelAllLocalNotifications];


    }
    
    //[[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
    
   
    
}



@end
