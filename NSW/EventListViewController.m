//
//  MasterViewController.m
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
    //NSDate *today; //TODO(Alex) use this to tell the data source what day we want
}

@end

@implementation EventListViewController


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //today = [NSDate date];
    myEventDS = [[EventDataSource alloc] initWithVCBackref:self];

}

#pragma mark - Table View


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
