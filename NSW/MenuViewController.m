//
// Created by Alex Simonides on 5/19/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"

@implementation DrawerTableViewCell
@end

@implementation MenuViewController

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

    switch ( indexPath.row )
    {
        case 0:
            CellIdentifier = @"events";
            break;

        case 1:
            CellIdentifier = @"map";
            break;

        case 2:
            CellIdentifier = @"terms";
            break;

        case 3:
            CellIdentifier = @"contacts";
            break;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];

    return cell;
}


@end