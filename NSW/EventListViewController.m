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
    NSArray *events;
    //EventDataSource *myEventDS;
    
}
@end

@implementation EventListViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.

    /*
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
     */
    
    EventDataSource *myEventDS = [[EventDataSource alloc] initWithVCBackref:self];
    
    /*NSWEvent * test = [[NSWEvent alloc] initWithTitle:@"NSW: Office of Intercultural and International Life Welcome Reception" Description:@"The Office of Intercultural and International Life (OIIL) invites students and parents to an informal outdoor reception. Tours of Stimson House, Carleton's intercultural center, also will be available. Enjoy some refreshments as we connect new students and their families to the Carleton community. Are you interested in having an OIIL Peer Leader? This is a great time to sign up. All are welcome. Rain location: Stimson House.f" Location:@"Alumni Guest House Patio" Start:@"20120904T140000" Duration:@"PT1H0M0S"];
    
    [events insertObject:test atIndex:0];
    [events insertObject:test atIndex:0];*/

    

}

-(void)getEventListFromDataSource:(NSArray *) dataSourceEventList{
    events = [[NSArray alloc] initWithArray: dataSourceEventList];
    //NSLog(@"%@", events[1]);
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
    return events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSWEvent *object = events[(NSUInteger) indexPath.row];
    cell.textLabel.text = [object title];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSWEvent *object = events[(NSUInteger) indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
