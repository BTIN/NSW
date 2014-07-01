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
    currentDate = [myEventDS parseDateTimeFromICSString:@"20120904T000000"]; //TODO Only for testing, eventually use [NSDate date]
    [myEventDS attachVCBackref:self];
    UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeLeft:)];
    
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
    
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(oneFingerSwipeRight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd"];
    
    NSString *current = [formatter stringFromDate:currentDate];
    
    // Changes "September 04" to "September 4" etc. for all dates. Doesn't matter for dates like "September 20" because NSW doesn't go that long
    NSString *currentDate = [current stringByReplacingOccurrencesOfString:@"0" withString:@""];
    
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
    [time setDateFormat:@"MMMM dd"];
    
    NSString *current = [time stringFromDate:currentDate];
    NSString *currentDate = [current stringByReplacingOccurrencesOfString:@"0" withString:@""];
    self.navigationController.navigationBar.topItem.title = currentDate;
    
}

// Checks the user defaults and shows directions if this is a first user
-(void)displayDirectionsIfNewUser {
    NSString *returningUserKey = @"returning user";
    //[NSUserDefaults resetStandardUserDefaults];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isReturningUser = [userDefaults boolForKey:returningUserKey];
    if (!isReturningUser) {
        iToast *swipeToast = [iToast makeText:@"Swipe left or right on this screen to change days"];
        [swipeToast setGravity:iToastGravityCenter];
        [swipeToast setDuration:iToastDurationNormal];
        [swipeToast show];

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
    NSLog([formatter stringFromDate:currentDate]);
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
    NSString *toDateString = [formatter stringFromDate:[NSWConstants firstDayOfNSW]];
    
    if (![currentDateString isEqualToString:toDateString]) {
        currentDate = [EventDataSource oneDayBefore:currentDate];
        [self getEventsFromCurrentDate];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
        [self updateDateLabelToCurrentDate];

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
