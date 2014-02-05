//
//  SearchViewController.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SearchViewController ()
{
    
    __weak IBOutlet UIView *containerFeed;
}
@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    containerFeed.layer.cornerRadius = 10;
    containerFeed.layer.masksToBounds = YES;
}

@end
