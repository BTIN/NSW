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

@interface EventListViewController () {
    EventDataSource *myEventDS;
    NSDate *currentDate;
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation EventListViewController



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        
    myEventDS = [[EventDataSource alloc] initWithVCBackref:self];
    currentDate = [myEventDS parseDateTimeFromICSString:@"20120904T000000"]; //TODO Only for testing, eventually use [NSDate date]
    UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeLeft:)];
    
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
    
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(oneFingerSwipeRight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
    
    NSDateFormatter *time = [[NSDateFormatter alloc] init];
    [time setDateFormat:@"MMMM dd"];
    
    NSString *current = [time stringFromDate:currentDate];
    self.navigationController.navigationBar.topItem.title = current;
    
    //[self.view addSubview:_dateLabel];
}

// Updates the event list to the events for currentDate
-(void)getEventsFromCurrentDate{
    [myEventDS getEventsForDate:currentDate];
}

#pragma mark - Table View
-(void)setHeaderLabel{
    _dateLabel.text = @"another day";
}

// Updates the label for the current day
-(void)updateDateLabelToCurrentDate {
    NSDateFormatter *time = [[NSDateFormatter alloc] init];
    [time setDateFormat:@"MMMM dd"];
    
    NSString *current = [time stringFromDate:currentDate];
    
    
    self.navigationController.navigationBar.topItem.title = current;
    

    //_dateLabel.text = current;
}

// Updates currentDate then the list of events to one day after the previous day
- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
    //TODO Nice-to-have: animation with swipe so that it's less of a sudden change
    NSLog(@"LEFT");
    currentDate = [EventDataSource oneDayAfter:currentDate];
    [self getEventsFromCurrentDate];
    [self updateDateLabelToCurrentDate];
}

// Updates currentDate then the list of events to one day before the previous day
- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    NSLog(@"RIGHT");
    currentDate = [EventDataSource oneDayBefore:currentDate];
    [self getEventsFromCurrentDate];
    [self updateDateLabelToCurrentDate];
}




- (EventTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //TODO handle cell-is-null case
    //TODO init custom table cell
    
    NSWEvent *event = self.listItems[(NSUInteger) indexPath.row];
    
    //Optionally for time zone converstions
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSDateFormatter *time = [[NSDateFormatter alloc] init];
    [time setDateFormat:@"hh:mm a"];

    NSString *startTime = [time stringFromDate:event.startDateTime];
    NSString *endTime = [time stringFromDate:event.endDateTime];
    if ([[startTime substringToIndex:1] isEqualToString:@"0"]){
        startTime = [startTime substringFromIndex:1];
    }if ([[endTime substringToIndex:1] isEqualToString:@"0"]){
        endTime = [endTime substringFromIndex:1];
    }
    NSString *startEnd = [NSString stringWithFormat:@"%@ - %@", startTime, endTime];
    cell.startEndLabel.text = startEnd;
    cell.eventNameLabel.text = [event title];
    
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
