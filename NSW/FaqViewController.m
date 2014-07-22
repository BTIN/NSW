//
//  FaqViewController.m
//  NSW
//
//  Created by Stephen Grinich on 7/21/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "FaqViewController.h"
#import "FaqDataSource.h"
#import "FaqItem.h"
#import "FaqTableViewCell.h"
#import "DataSourceManager.h"
#import "NSWStyle.h"
//#import "FaqDetailViewController.h"

@interface FaqViewController (){
    
}

@end

@implementation FaqViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

int selectedIndex;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"FAQs";
    
    //Connect this VC to the shared DataSource
    [[[DataSourceManager sharedDSManager] getFaqDataSource] attachVCBackref:self];
    
}

- (FaqTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"test"); 
    FaqTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    FaqItem *item = self.listItems[(NSUInteger) indexPath.row];
    cell.questionLabel.text = @"Hello!";//[item question];
    
    
    
    /*
 
    
    cell.longNameLabel.text = [term longName];
    cell.abbreviationLabel.text = [term abbreviation];
    cell.abbreviationLabel.textColor = [NSWStyle oceanBlueColor];
    cell.longNameLabel.numberOfLines = 1;
     
     */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}









- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
