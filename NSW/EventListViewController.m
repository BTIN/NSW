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
    NSDate *today; //TODO(Alex) use this to tell the data source what day we want
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation EventListViewController


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //today = [NSDate date];
    myEventDS = [[EventDataSource alloc] initWithVCBackref:self];
    
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
    _dateLabel.text = today;
    
    //[self.view addSubview:_dateLabel];

}

#pragma mark - Table View
-(void)setHeaderLabel{
    _dateLabel.text = @"another day";
}


- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
    NSLog(@"LEFT");
    [myEventDS setEmpty];

    
}

- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    NSLog(@"RIGHT");
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
