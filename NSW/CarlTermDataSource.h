//
//  DictionaryDataSource.h
//  NSW
//
//  Created by Alex Simonides on 5/13/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNSWDataSource.h"
#import "CarlTermViewController.h"

@interface CarlTermDataSource : BaseNSWDataSource

@property (nonatomic, strong) NSMutableArray *abbreviationList;
-(id)initWithVCBackref:(CarlTermViewController *) carlTermViewController;


@end
