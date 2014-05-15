//
// Created by Alex Simonides on 5/15/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "BaseNSWTableViewController.h"


@implementation BaseNSWTableViewController {

}
@synthesize listItems;

// Called by the DataSource when it's ready to update the VC with its objects
- (void)setVCArrayToDataSourceArray:(NSArray *)dataSourceObjects {
    self.listItems = [[NSArray alloc] initWithArray:dataSourceObjects];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listItems.count;
}

@end