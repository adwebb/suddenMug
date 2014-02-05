//
//  SearchViewController.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FeedViewController.h"

@interface SearchViewController () <UISearchBarDelegate>
{
    
    __weak IBOutlet UIView *containerFeed;
    FeedViewController* fvc;
}
@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    containerFeed.layer.cornerRadius = 10;
    containerFeed.layer.masksToBounds = YES;
    fvc = [self.childViewControllers objectAtIndex:0];
    fvc.usersToDisplay = nil;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    PFQuery* query = [PFUser query];
    [query whereKey:@"username" containsString:searchBar.text];
    [fvc setUsersToDisplay:[query findObjects]];
    [searchBar resignFirstResponder];
}

@end
