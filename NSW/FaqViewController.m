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
#import "FaqDetailViewController.h"

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
    
    FaqTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    FaqItem *item = self.listItems[(NSUInteger) indexPath.row];
    cell.questionLabel.text = [item question];
    

    return cell;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    FaqItem *item = self.listItems[(NSUInteger) indexPath.row];
    FaqDetailViewController *destFaqViewController = segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"showAnswerDetail"]) {
        
        destFaqViewController.question = [item question];
        destFaqViewController.answer = [item answer];
        
        
    }
}



@end
