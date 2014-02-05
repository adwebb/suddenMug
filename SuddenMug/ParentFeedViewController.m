//
//  ParentFeedViewController.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/5/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "ParentFeedViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FeedViewController.h"

@interface ParentFeedViewController ()
{
    __weak IBOutlet UIView *containerFeed;
    FeedViewController* fvc;
}
@end

@implementation ParentFeedViewController

- (void)viewDidLoad
{
    fvc = [self.childViewControllers objectAtIndex:0];
    PFQuery* query = [PFUser query];
    [fvc setUsersToDisplay:[query findObjects]];
    
    [super viewDidLoad];
	containerFeed.layer.cornerRadius = 10;
    containerFeed.layer.masksToBounds = YES;
 
}



@end
