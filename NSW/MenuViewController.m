//
// Created by Alex Simonides on 5/19/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"
#import "NSWStyle.h"

@interface MenuViewController ()

@property (nonatomic, strong) NSArray *menuIDs;
@property (nonatomic, strong) NSArray *menuTitles;

@end


@implementation MenuViewController

- (void)viewDidLoad {
    self.tableView.backgroundColor = [NSWStyle lightBlueColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;

    // Add gestures to return to current view by tapping or panning (dragging) the menu away
    [self.revealViewController tapGestureRecognizer];
    //[self.revealViewController panGestureRecognizer];

    self.menuIDs = @[@"events", @"map", @"terms", @"contacts"];
    self.menuTitles = @[@"Schedule", @"Campus Map", @"Speak Carleton", @"Important Contacts"];
}

// boilerplate preparation for storyboard segues
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // configure the destination view controller:

    // configure the segue.
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
    {
        SWRevealViewControllerSegue *swRevealSegue = (SWRevealViewControllerSegue*) segue;

        SWRevealViewController *revealVC = self.revealViewController;
        NSAssert( revealVC != nil, @"oops! must have a revealViewController" );

        NSAssert( [revealVC.frontViewController isKindOfClass: [UINavigationController class]], @"oops!  for this segue we want a permanent navigation controller in the front!" );

        swRevealSegue.performBlock = ^(SWRevealViewControllerSegue* revealVCSegue, UIViewController* svc, UIViewController*destinationVC)
        {
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:destinationVC];
            [revealVC pushFrontViewController:navigationController animated:YES];
        };
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *headerID = @"MenuHeaderID";
    UITableViewHeaderFooterView *menuHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (!menuHeaderView) {
        menuHeaderView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerID];
        menuHeaderView.contentView.backgroundColor = [NSWStyle lightBlueColor];
        //menuHeaderView.textLabel.text = @"Carleton NSW";
        //menuHeaderView.textLabel.textColor = [NSWStyle whiteColor];
        //menuHeaderView.textLabel.font = [NSWStyle boldFont];

    }
    return menuHeaderView;
}

#pragma mark - Table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CellIdentifier = [self.menuIDs objectAtIndex:(NSUInteger) indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [NSWStyle lightBlueColor];
    cell.textLabel.textColor = [NSWStyle whiteColor];
    cell.textLabel.font = [NSWStyle boldFont];
    cell.textLabel.text = [self.menuTitles objectAtIndex:(NSUInteger) indexPath.row];

    return cell;
}


@end