//
//  GoogleMapViewController.m
//  NSW
//
//  Created by Lab User on 6/3/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "GoogleMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "SWRevealViewController.h"
#import "NSWStyle.h"

@interface GoogleMapViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@end

@implementation GoogleMapViewController{
    GMSMapView *mapView_;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIStoryboard *aStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    mapView_ = [aStoryboard instantiateViewControllerWithIdentifier:@"gMap"];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:44.461
                                                            longitude:-93.1546
                                                                 zoom:17];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    
    self.navigationItem.title = @"Map of Campus";
    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    [self setNavigationColors];
    self.view.backgroundColor = [NSWStyle lightBlueColor];
	// Do any additional setup after loading the view.
}


//This is directly lifted from BaseNSWTableViewController, can we put it in an interface or such?
- (void)setNavigationColors{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.translucent = NO;
    navBar.barTintColor = [NSWStyle lightBlueColor];
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [NSWStyle whiteColor],
                                     NSFontAttributeName : [NSWStyle boldFont]}];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(popoverArrowDirection)];
    self.navigationItem.backBarButtonItem = barBtnItem;
    //"navBar text color" = [NSWStyle whiteColor];
    self.revealButtonItem.tintColor = [NSWStyle whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
