//
//  EventListViewController.m
//  NSW
//
//  Created by Stephen Grinich on 5/7/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "EventListViewController.h"

#import "EventDataSource.h"
#import "NSWEvent.h"
#import "EventTableViewCell.h"
#import "EventDetailViewController.h"
#import "NSWStyle.h"
#import "DataSourceManager.h"
#import "iToast.h"
#import "NSWConstants.h"
#import "SWRevealViewController.h"


@interface EventListViewController () {
    EventDataSource *myEventDS;
    NSDate *currentDate;
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation EventListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self displayDirectionsIfNewUser];


    //Connect this VC to the shared DataSource
    myEventDS = [[DataSourceManager sharedDSManager] getEventDataSource];
    
    //initial date shown, should be whatever day it is if your current day is within nsw
    // if I put it a day ahead it seems to work? otherwise the initial date is one day back
    //currentDate = [myEventDS parseDateTimeFromICSString:@"20140909T000000"]; //TODO Only for testing, eventually use [NSDate date]
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:9];
    [comps setMonth:9];
    [comps setYear:2014];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    currentDate = [gregorian dateFromComponents:comps];
    
    
    
    
    
    [myEventDS attachVCBackref:self];
    
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];

    
    UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeLeft:)];
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(oneFingerSwipeRight:)];
    
    
    
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
    
    
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
    
    
    // for nav bar
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd"];
    
    // get full day of week
    NSDateFormatter *dayOfWeek = [[NSDateFormatter alloc] init];
    [dayOfWeek setDateFormat:@"EEEE"];
    
    // string for nav bar day name
    NSString *dayName = [dayOfWeek stringFromDate:currentDate];
    
    // string for nav bar date
    NSString *current = [formatter stringFromDate:currentDate];
    
    // Changes "September 04" to "September 4" etc. for all dates. Doesn't matter for dates like "September 20" because NSW doesn't go that long
    NSString *currentDate = [current stringByReplacingOccurrencesOfString:@"0" withString:@""];
    
    // nav bar ex: "Saturday, Sep 13"
    //currentDate = [NSString stringWithFormat:@"%@%@%@", dayName, @", ", currentDate];
    
    // nav bar ex: "Saturday"
    currentDate = [NSString stringWithFormat:@"%@", dayName];
    
    // set title for navigation bar
    self.navigationController.navigationBar.topItem.title = currentDate;
    
}





// Updates the event list to the events for currentDate
-(void)getEventsFromCurrentDate {
    [myEventDS getEventsForDate:currentDate];
}

#pragma mark - Table View

// Updates the label for the current day
-(void)updateDateLabelToCurrentDate {
    NSDateFormatter *time = [[NSDateFormatter alloc] init];
    [time setDateFormat:@"MMM dd"];
    
    
    NSDateFormatter *dayOfWeek = [[NSDateFormatter alloc] init];
    [dayOfWeek setDateFormat:@"EEEE"];
    NSString *dayName = [dayOfWeek stringFromDate:currentDate];
             
    
    
    NSString *current = [time stringFromDate:currentDate];
    NSString *currentDate = [current stringByReplacingOccurrencesOfString:@"0" withString:@""];
                                  
    currentDate = [NSString stringWithFormat:@"%@", dayName];
                                  
    self.navigationController.navigationBar.topItem.title = currentDate;
    
}

// Checks the user defaults and shows directions if this is a first user
-(void)displayDirectionsIfNewUser {
    NSString *returningUserKey = @"returning user";
    //[NSUserDefaults resetStandardUserDefaults];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isReturningUser = [userDefaults boolForKey:returningUserKey];
    if (!isReturningUser) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to Carleton!"
                                                        message:@"Swipe left or right on this screen to view events for different days"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

        [userDefaults setBool:YES forKey:returningUserKey];
    } else {
        //[userDefaults setBool:NO forKey:returningUserKey];
    }
}

// Updates currentDate then the list of events to one day after the previous day
- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
    //TODO Nice-to-have: animation with swipe so that it's less of a sudden change
    NSLog(@"LEFT");
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"current date: ");
    NSLog([formatter stringFromDate:currentDate]);
    NSLog(@"first day of nsw: ");
    NSLog([formatter stringFromDate:[NSWConstants firstDayOfNSW]]);

    NSString *currentDateString =[formatter stringFromDate:currentDate];
    NSString *toDateString = [formatter stringFromDate:[NSWConstants lastDayOfNSW]];
    
    if (![currentDateString isEqualToString:toDateString]) {
        currentDate = [EventDataSource oneDayAfter:currentDate];
        [self getEventsFromCurrentDate];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        [self updateDateLabelToCurrentDate];
    }
}

// Updates currentDate then the list of events to one day before the previous day
- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    NSLog(@"RIGHT");
    
    
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *currentDateString =[formatter stringFromDate:currentDate];
        NSLog(currentDateString);
    
        NSString *toDateString = [formatter stringFromDate:[NSWConstants firstDayOfNSW]];
    
        if (![currentDateString isEqualToString:toDateString]) {
            currentDate = [EventDataSource oneDayBefore:currentDate];
            [self getEventsFromCurrentDate];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
            [self updateDateLabelToCurrentDate];

        }
        
    
    
}



- (IBAction)calendarButton:(id)sender {
        
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select a day to jump to" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                           @"Tuesday, September 9",
                           @"Wednesday, September 10",
                           @"Thursday, September 11",
                           @"Friday, September 12",
                           @"Saturday, September 13",
                           @"Sunday, September 14",
                           nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];

    
    
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *dateString;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];

    
    if(buttonIndex == 0){
        dateString = @"2014-09-09";
        currentDate = [formatter dateFromString:dateString];
        [self getEventsFromCurrentDate];
        [self updateDateLabelToCurrentDate];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];

    }
    
    if(buttonIndex == 1){
        dateString = @"2014-09-10";
        currentDate = [formatter dateFromString:dateString];
        [self getEventsFromCurrentDate];
        [self updateDateLabelToCurrentDate];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];

    }
    
    if(buttonIndex == 2){
        dateString = @"2014-09-11";
        currentDate = [formatter dateFromString:dateString];
        [self getEventsFromCurrentDate];
        [self updateDateLabelToCurrentDate];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    if(buttonIndex == 3){
        dateString = @"2014-09-12";
        currentDate = [formatter dateFromString:dateString];
        [self getEventsFromCurrentDate];
        [self updateDateLabelToCurrentDate];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    if(buttonIndex == 4){
        dateString = @"2014-09-13";
        currentDate = [formatter dateFromString:dateString];
        [self getEventsFromCurrentDate];
        [self updateDateLabelToCurrentDate];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    if(buttonIndex == 5){
        dateString = @"2014-09-14";
        currentDate = [formatter dateFromString:dateString];
        [self getEventsFromCurrentDate];
        [self updateDateLabelToCurrentDate];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    else{
        
    }
    
    
   
    
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    for (UIView *subview in actionSheet.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            [button setTitleColor:[NSWStyle oceanBlueColor] forState:UIControlStateNormal];
        }
    }
}





- (EventTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSWEvent *event = self.listItems[(NSUInteger) indexPath.row];
    
    //Optionally for time zone conversions
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSDateFormatter *time = [[NSDateFormatter alloc] init];
    [time setDateFormat:@"hh:mm a"];

    NSString *startTime = [time stringFromDate:event.startDateTime];
    NSString *endTime = [time stringFromDate:event.endDateTime];
    
    if ([[startTime substringToIndex:1] isEqualToString:@"0"]){
        startTime = [startTime substringFromIndex:1];
    }
    
    if ([[endTime substringToIndex:1] isEqualToString:@"0"]){
        endTime = [endTime substringFromIndex:1];
    }
    
    // Removes end time if start time and end time are the same. Also adds hyphen accordingly. 
    NSString *startEnd;
    if ([startTime isEqualToString:endTime]) {
        endTime = @"";
        startEnd = startTime;
    }
    else{
        startEnd = [NSString stringWithFormat:@"%@ - %@", startTime, endTime];
    }
    
    cell.startEndLabel.text = startEnd;
    cell.startEndLabel.textColor = [NSWStyle darkBlueColor];
    
    
    // Remove "NSW: " from event title
    NSString *eventNameString = [event title];
    NSString *eventNameStringFirstFourChars = [eventNameString substringToIndex:5];
    if([eventNameStringFirstFourChars  isEqual: @"NSW: "]){
        eventNameString = [eventNameString substringFromIndex:5];
    }
    
    
    
    cell.eventNameLabel.text = eventNameString;
    cell.eventNameLabel.textColor = [NSWStyle darkBlueColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self performSegueWithIdentifier:@"showDetail" sender:self];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSWEvent *object = self.listItems[(NSUInteger) indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}



@end
