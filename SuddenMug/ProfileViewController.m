//
//  ProfileViewController.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "FeedViewController.h"
#import "TabController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface ProfileViewController ()<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
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
    
    __weak IBOutlet UIButton *signOutButton;
    
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
    
    [signOutButton.titleLabel setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    
    userLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:30];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    FeedViewController* fvc = [self.childViewControllers objectAtIndex:0];
    [fvc setUsersToDisplay:@[[PFUser currentUser]]];
    [fvc.tableView reloadData];
    userLabel.text = [PFUser currentUser].username;
    [self queryAll];
}

-(void)queryAll
{
    [self queryFollowers];
    [self queryFollowing];
    [self queryLikes];
    [self queryPhotos];
    [self queryComments];
}

-(void)queryFollowers
{
    PFQuery *query = [PFQuery queryWithClassName:@"Following"];
    [query whereKey:@"userFollowed" equalTo:[PFUser currentUser][@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        followersCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)objects.count];
    }];
}

-(void)queryFollowing
{
    PFQuery *query = [PFQuery queryWithClassName:@"Following"];
    [query whereKey:@"userFollowing" equalTo:[PFUser currentUser][@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        followingsCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)objects.count];
    }];
}

-(void)queryLikes
{
    PFQuery *query = [PFQuery queryWithClassName:@"Like"];
    [query whereKey:@"username" equalTo:[PFUser currentUser][@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        likeCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)objects.count];
    }];
}

-(void)queryPhotos
{
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query whereKey:@"username" equalTo:[PFUser currentUser][@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        photoCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)objects.count];
    }];
}
-(void)queryComments
{
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query whereKey:@"author" equalTo:[PFUser currentUser][@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        commentCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)objects.count];
    }];
}
- (IBAction)onSignOutButtonPressed:(id)sender
{
    [PFUser logOut];
    [self login];
}

-(void)login
{
    LoginViewController* login = [LoginViewController new];
    login.delegate = self;
    login.signUpController.delegate = self;
    UIImageView* logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    login.logInView.logo = logo;
    
    [self presentViewController:login animated:YES completion:nil];
    
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self viewWillAppear:YES];
    [logInController dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [signUpController dismissViewControllerAnimated:YES completion:nil];
}

@end
