//
// Created by Alex Simonides on 5/20/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"

@interface MapViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}
@end