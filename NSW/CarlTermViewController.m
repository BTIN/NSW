//
//  CarlTermTableViewController.m
//  NSW
//
//  Created by Alex Simonides on 5/13/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "CarlTermViewController.h"
#import "CarlTermDataSource.h"
#import "CarlTerm.h"
#import "CarlTermTableViewCell.h"
#import "NSWStyle.h"
#import "DataSourceManager.h"

@interface CarlTermViewController (){
}
@end

@implementation CarlTermViewController

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
    selectedIndex = -1;

    //Connect this VC to the shared DataSource
    [[[DataSourceManager sharedDSManager] getCarlTermDataSource] attachVCBackref:self];

}


- (CarlTermTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarlTermTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    CarlTerm *term = self.listItems[(NSUInteger) indexPath.row];
    cell.longNameLabel.text = [term longName];
    cell.abbreviationLabel.text = [term abbreviation];
    cell.abbreviationLabel.textColor = [NSWStyle lightBlueColor];
    cell.longNameLabel.numberOfLines = 1;
    return cell;
}

/*
 Set selectedIndex to the clicked indexPath. [tableView begin/endUpdates] will reload view, calling heightForRowAtIndexPath. This sets the cell at selectedIndex to have a height 80
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedIndex == [indexPath row]){
        CarlTermTableViewCell *cell = (CarlTermTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
        cell.longNameLabel.numberOfLines = 1;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        selectedIndex = -1;
    }
    else {
        CarlTermTableViewCell *cell = (CarlTermTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
        cell.longNameLabel.numberOfLines = 0;   //0 means unbounded in this case
        cell.accessoryType = UITableViewCellAccessoryNone;
        selectedIndex = [indexPath row];
    }

    [tableView beginUpdates];
    [tableView endUpdates];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == selectedIndex) {
        return  80;
    }
    else return 40;
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
