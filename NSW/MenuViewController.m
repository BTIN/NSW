//
// Created by Alex Simonides on 5/19/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"
#import "NSWStyle.h"

@implementation DrawerTableViewCell
@end

@implementation MenuViewController

- (void)viewDidLoad {
    self.tableView.backgroundColor = [NSWStyle lightBlueColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *optionTitle = @"Cell";

    switch ( indexPath.row )
    {
        case 0:
            CellIdentifier = @"events";
            optionTitle = @"Schedule";
            break;

        case 1:
            CellIdentifier = @"map";
            optionTitle = @"Campus Map";
            break;

        case 2:
            CellIdentifier = @"terms";
            optionTitle = @"CarleTerms";
            break;

        case 3:
            CellIdentifier = @"contacts";
            optionTitle = @"Important Contacts";
            break;
        default:break;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
    cell.backgroundColor = [NSWStyle lightBlueColor];
    cell.textLabel.textColor = [NSWStyle whiteColor];
    cell.textLabel.font = [NSWStyle boldFont];
    cell.textLabel.text = optionTitle;

    return cell;
}


@end