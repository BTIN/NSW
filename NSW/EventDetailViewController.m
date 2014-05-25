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
@property (weak, nonatomic) IBOutlet UILabel *eventLocation;
@property (weak, nonatomic) IBOutlet UILabel *eventDescription;
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;
@property (weak, nonatomic) IBOutlet UILabel *durationDescription;
//@property (weak, nonatomic) IBOutlet UINavigationItem *titleDescriptionLabel;
- (void)configureView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeDescriptionLabel;
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
        
        // Convert NSDate to NSString
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        //[dateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss"];
        
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        NSString *string = [dateFormatter stringFromDate:[self.detailItem startDateTime]];
        
        self.eventDescription.adjustsFontSizeToFitWidth = YES;
        [self.eventDescription sizeToFit];
        self.startTimeDescriptionLabel.text = string;
        self.title =[self.detailItem title];
        self.eventDescription.text = [self.detailItem theDescription];
        
        // Convert NSNumber to NSString for minutes
        NSTimeInterval descriptionNumber = [self.detailItem duration];
        int descriptionInteger = (int) descriptionNumber;
        descriptionInteger = descriptionInteger/60;
        
        
        NSMutableString *descriptionString = [NSMutableString stringWithFormat:@"%d",descriptionInteger];
        
        [descriptionString appendString:@" minutes"];
        
        self.durationDescription.text = descriptionString;
        
    }
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
- (IBAction)notificationButton:(id)sender {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNotification.alertBody = @"Notification Test";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    

}



@end
