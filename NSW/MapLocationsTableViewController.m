//
//  MapLocationsTableViewController.m
//  NSW
//
//  Created by Stephen Grinich on 7/27/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "MapLocationsTableViewController.h"
#import "LocationTableViewCell.h"
#import "MapLocation.h"
#import <GoogleMaps/GoogleMaps.h>


@interface MapLocationsTableViewController ()

@end

@implementation MapLocationsTableViewController

@synthesize locationsList = _locationsList;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    _locationsList = [[NSMutableArray alloc] init];
    
    
    // Goodhue Hall
    GMSMarker *goodhueMarker = [[GMSMarker alloc] init];
    goodhueMarker.position = CLLocationCoordinate2DMake(44.462455, -93.149728);
    goodhueMarker.title = @"Goodhue Hall";
    MapLocation *goodhue = [[MapLocation alloc]initWithLocation:@"Goodhue" Coordinates:goodhueMarker];
    [_locationsList addObject:goodhue];

    
    
    
    return [_locationsList count];
}


- (LocationTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSLog(@"test", [[_locationsList objectAtIndex:indexPath.row] maplocation]); 
    
    
    cell.locationLabel.text = [[_locationsList objectAtIndex:indexPath.row] maplocation];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MapLocation *selectedLocation = [_locationsList objectAtIndex:[indexPath row]];
    
   
    [self.delegate addItemViewController:self didFinishEnteringItem:selectedLocation];
    
    
    //animate view to close here?
    [self dismissModalViewControllerAnimated:YES];
}
    
    
    



@end
