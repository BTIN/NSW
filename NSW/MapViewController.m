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


UIImageView *mapImageView;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIStoryboard *aStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    mapImageView = [aStoryboard instantiateViewControllerWithIdentifier:@"mapImage"];
    
    UIPanGestureRecognizer *panTagGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panTagGesture setDelegate:self];
    [mapImageView addGestureRecognizer:panTagGesture];
    
    UIPinchGestureRecognizer *pinchTagGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [pinchTagGesture setDelegate:self];
    [mapImageView addGestureRecognizer:pinchTagGesture];
    
    
     self.navigationItem.title = @"Map of Campus";
    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}

CGFloat lastScale;

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales
        lastScale = [recognizer scale];
    }
    
    if ([recognizer state] == UIGestureRecognizerStateBegan ||
        [recognizer state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[recognizer view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom
        const CGFloat kMaxScale = 3.0;
        const CGFloat kMinScale = 1.0;
        
        CGFloat newScale = 1 -  (lastScale - [recognizer scale]); // new scale is in the range (0-1)
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale([[recognizer view] transform], newScale, newScale);
        [recognizer view].transform = transform;
        
        lastScale = [recognizer scale];  // Store the previous scale factor for the next pinch gesture call
    }
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint point = [recognizer locationInView:mapImageView];
    
    CGRect mapImageViewBounds = mapImageView.bounds;
    CGRect mapImageViewFrame  =  mapImageView.frame;
    
     //NSLog(@"%@", mapImageViewBounds;

    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

    
}

@end