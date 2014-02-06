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
    FeedViewController* fvc = [self.childViewControllers objectAtIndex:0];
    [fvc setUsersToDisplay:@[[PFUser currentUser]]];
    
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
        followersCountLabel.text = [NSString stringWithFormat:@"%i",objects.count];
    }];
}

-(void)queryFollowing
{
    PFQuery *query = [PFQuery queryWithClassName:@"Following"];
    [query whereKey:@"userFollowing" equalTo:[PFUser currentUser][@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        followingsCountLabel.text = [NSString stringWithFormat:@"%i",objects.count];
    }];
}

-(void)queryLikes
{
    PFQuery *query = [PFQuery queryWithClassName:@"Like"];
    [query whereKey:@"username" equalTo:[PFUser currentUser][@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        likeCountLabel.text = [NSString stringWithFormat:@"%i",objects.count];
    }];
}

-(void)queryPhotos
{
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query whereKey:@"username" equalTo:[PFUser currentUser][@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        photoCountLabel.text = [NSString stringWithFormat:@"%i",objects.count];
    }];
}
-(void)queryComments
{
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query whereKey:@"author" equalTo:[PFUser currentUser][@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        commentCountLabel.text = [NSString stringWithFormat:@"%i",objects.count];
    }];
}

@end
