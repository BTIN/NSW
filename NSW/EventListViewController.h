//
//  MasterViewController.h
//  NSW
//
//  Created by Stephen Grinich on 5/7/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventListViewController : UITableViewController


-(void)getEventListFromDataSource:(NSArray *)dataSourceEventList;
@end
