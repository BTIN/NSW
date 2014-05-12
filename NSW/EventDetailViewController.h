//
//  DetailViewController.h
//  NSW
//
//  Created by Stephen Grinich on 5/7/14.
//  Copyright (c) 2014 Stephen Grinich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailViewController : UIViewController

@property (strong, nonatomic) Event * detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
