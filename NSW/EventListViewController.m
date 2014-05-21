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

#import "EventDetailViewController.h"

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
    
    /*
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *stringFromDate = [formatter stringFromDate:myNSDateInstance];
    */
    _dateLabel.text = currentDate.description;
    
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
    _dateLabel.text = currentDate.description;
}

// Updates currentDate then the list of events to one day after the previous day
- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
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




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSWEvent *event = self.listItems[(NSUInteger) indexPath.row];
    cell.textLabel.text = [event title];
    return cell;
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
