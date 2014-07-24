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
    /* Sections will be in this order and include:
     -- NewStudents
     -- Housing
     -- OneCard
     -- PostOffice
     -- SHAC
     -- Advising
     -- ITS
     -- Language
     -- PrintServices
     -- DisabilityService
     -- Miscellaneous
     */
    
    
    
}


@end

@implementation FaqViewController

@synthesize studentsSection = _studentsSection;
@synthesize housingSection  = _housingSection;
@synthesize oneCardSection = _oneCardSection;
@synthesize postOfficeSection = _postOfficeSection;
@synthesize shacSection = _shacSection;
@synthesize advisingSection = _advisingSection;
@synthesize itsSection = _itsSection; 
@synthesize languageSection = _languageSection;
@synthesize printServicesSection = _printServicesSection;
@synthesize disabilityServiceSection = _disabilityServiceSection;
@synthesize miscSection = _miscSection;



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
    NSLog(@"cell for row at index path");
    
    FaqTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //FaqItem *item = self.listItems[(NSUInteger) indexPath.row];
    //cell.questionLabel.text = [item question];
    
    switch (indexPath.section) {
        case 0:
            cell.questionLabel.text = [[_studentsSection objectAtIndex:indexPath.row] question];
            break;
            
        case 1:
            cell.questionLabel.text = [[_housingSection objectAtIndex:indexPath.row] question];
            break;
            
        case 2:
            cell.questionLabel.text = [[_oneCardSection objectAtIndex:indexPath.row] question];
            break;
            
        case 3:
            cell.questionLabel.text = [[_postOfficeSection objectAtIndex:indexPath.row] question];
            break;
            
        case 4:
            cell.questionLabel.text = [[_shacSection objectAtIndex:indexPath.row] question];
            break;
            
        case 5:
            cell.questionLabel.text = [[_advisingSection objectAtIndex:indexPath.row] question];
            break;
            
        case 6:
            cell.questionLabel.text = [[_itsSection objectAtIndex:indexPath.row] question];
            break;
            
        case 7:
            cell.questionLabel.text = [[_languageSection objectAtIndex:indexPath.row] question];
            break;
            
        case 8:
            cell.questionLabel.text = [[_printServicesSection objectAtIndex:indexPath.row] question];
            break;
            
        case 9:
            cell.questionLabel.text = [[_disabilityServiceSection objectAtIndex:indexPath.row] question];
            break;
            
        case 10:
            cell.questionLabel.text = [[_miscSection objectAtIndex:indexPath.row] question];
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 11;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    _studentsSection = [NSMutableArray array];
    _housingSection = [NSMutableArray array];
    _oneCardSection = [NSMutableArray array];
    _postOfficeSection = [NSMutableArray array];
    _shacSection = [NSMutableArray array];
    _advisingSection = [NSMutableArray array];
    _itsSection = [NSMutableArray array];
    _languageSection = [NSMutableArray array];
    _printServicesSection = [NSMutableArray array];
    _disabilityServiceSection = [NSMutableArray array];
    _miscSection = [NSMutableArray array];
    
    
    for(FaqItem *item in self.listItems){
        
        if([[item section] isEqualToString:@"NewStudents"]){
            [_studentsSection addObject:item];
            
        }
        
        else if([[item section] isEqualToString:@"Housing"]){
            [_housingSection addObject:item];
            
        }
        
        else if([[item section] isEqualToString:@"OneCard"]){
            [_oneCardSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"PostOffice"]){
            [_postOfficeSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"SHAC"]){
            [_shacSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"Advising"]){
            [_advisingSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"ITS"]){
            [_itsSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"Language"]){
            [_languageSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"PrintServices"]){
            [_printServicesSection addObject:item];
        }
        else if([[item section] isEqualToString:@"DisabilityService"]){
            [_disabilityServiceSection addObject:item];
        }
        else if([[item section] isEqualToString:@"Miscellaneous"]){
            [_miscSection addObject:item];
        }
        
    }
    
    int count = 0;
    switch (section) {
        case 0:
            count = [_studentsSection count];
            break;
            
        case 1:
            count = [_housingSection count];
            break;
            
        case 2:
            count = [_oneCardSection count];
            break;
        
        case 3:
            count = [_postOfficeSection count];
            break;
        
        case 4:
            count = [_shacSection count];
            break;
            
        case 5:
            count = [_advisingSection count];
            break;
        
        case 6:
            count = [_itsSection count];
            break;
            
        case 7:
            count = [_languageSection count];
            break;
            
        case 8:
            count = [_printServicesSection count];
            break;
        
        case 9:
            count = [_disabilityServiceSection count];
            break;
        
        case 10:
            count = [_miscSection count];
            break;

        default:
            break;
    }
    return count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = @"";
    
    switch (section) {
        case 0:
            title = @"New Students 2014";
            break;
        case 1:
            title = @"Housing";
            break;
        case 2:
            title = @"OneCard";
            break;
        case 3:
            title = @"Post Office";
            break;
        case 4:
            title = @"SHAC";
            break;
        case 5:
            title = @"Advising";
            break;
        case 6:
            title = @"ITS";
            break;
        case 7:
            title = @"Language Placement";
            break;
        case 8:
            title = @"Print Services";
            break;
        case 9:
            title = @"Disability Services";
            break;
        case 10:
            title = @"Miscellaneous";
            break;
            
        default:
            break;
    }
    
    return title;
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
