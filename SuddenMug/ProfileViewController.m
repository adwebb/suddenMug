//
//  ProfileViewController.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"

@interface ProfileViewController ()
{
    IBOutlet UIView* profileView;
    
    __weak IBOutlet UILabel *userLabel;
    __weak IBOutlet UILabel *photoCountLabel;
    __weak IBOutlet UILabel *commentCountLabel;
    __weak IBOutlet UILabel *likeCountLabel;
    __weak IBOutlet UILabel *followersCountLabel;
    __weak IBOutlet UILabel *followingsCountLabel;
    __weak IBOutlet UIView *containerFeed;
    IBOutletCollection(UIButton) NSArray *buttons;
    
    
}
@end

@implementation ProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    profileView.layer.cornerRadius = 10;
    profileView.layer.masksToBounds = YES;
    for (UIButton* button in buttons) {
        if([button isKindOfClass:[UIButton class]])
        {
            button.layer.cornerRadius = 10;
            button.layer.masksToBounds = YES;
        }
    }
    containerFeed.layer.cornerRadius = 10;
    containerFeed.layer.masksToBounds = YES;
    userLabel.text = [PFUser currentUser].username;
    userLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:30];
}

@end
