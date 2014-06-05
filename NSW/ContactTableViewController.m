//
//  ContactTableViewController.m
//  NSW
//
//  Created by Alex Simonides on 5/12/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "ContactTableViewController.h"
#import "ContactTableViewCell.h"
#import "Contact.h"
#import "ContactDataSource.h"
#import "DataSourceManager.h"
#import <QuartzCore/QuartzCore.h>

@interface ContactTableViewController ()



@end

@implementation ContactTableViewController

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
    
    self.listItems = [[NSMutableArray alloc] init];
    
    //Connect this VC to the shared DataSource
    [[[DataSourceManager sharedDSManager] getContactDataSource] attachVCBackref:self];

}
- (IBAction)phoneLabel:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSString *promptprefix = @"tel://";
    NSString *callprompt = [promptprefix stringByAppendingString:button.currentTitle];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callprompt]];
}

- (IBAction)emailLabel:(id)sender {
    //emailto
}

- (ContactTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    Contact *contact = self.listItems[(NSUInteger) indexPath.row];
    cell.titleLabel.text = [contact title];
    [cell.phoneLabel setTitle:[contact phone] forState:UIControlStateNormal];
    [cell.emailLabel setTitle:[contact email] forState:UIControlStateNormal];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
