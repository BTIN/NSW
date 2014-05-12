//
//  DetailViewController.m
//  NSW
//
//  Created by Stephen Grinich on 5/7/14.
//  Copyright (c) 2014 Stephen Grinich. All rights reserved.
//

#import "DetailViewController.h"
#import "Event.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *titleDescriptionLabel;
- (void)configureView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeDescriptionLabel;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Event *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem location];
        
        // Convert NSDate to NSString
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSString *string = [dateFormatter stringFromDate:[self.detailItem startDateTime]];
        
        self.startTimeDescriptionLabel.text = string;
        self.title =[self.detailItem title];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
