//
//  PhotoDetailViewController.m
//  SuddenMug
//
//  Created by Fletcher Rhoads on 2/5/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PhotoDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation PhotoDetailViewController
{
    
    __weak IBOutlet PFImageView *thumbnailImageView;
    __weak IBOutlet UIButton *likeDetailButton;
    __weak IBOutlet UIButton *followDetailButton;
    __weak IBOutlet UITextField *commentTextField;
    __weak IBOutlet UILabel *followLabel;
    __weak IBOutlet UILabel *likeLabel;
    __weak IBOutlet UILabel *posterName;
    __weak IBOutlet UITableView *commentTable;
    __weak IBOutlet UIButton* postButton;
    __weak IBOutlet UIView *shader;
    NSArray *comments;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    thumbnailImageView.file = self.photo[@"image"];
    [thumbnailImageView loadInBackground];
    [self queryAll];
    
    thumbnailImageView.layer.cornerRadius = 10;
    thumbnailImageView.layer.masksToBounds = YES;
    
    commentTable.layer.cornerRadius = 10;
    commentTable.layer.masksToBounds = YES;
    
    commentTextField.background = [UIImage imageNamed:@"textfield"];
    commentTextField.font = [UIFont fontWithName:@"DKCrayonCrumble" size:18];
    
    [postButton.titleLabel setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    
    followLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:20];
    posterName.font = [UIFont fontWithName:@"DKCrayonCrumble" size:30];
    likeLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:20];
    
    likeDetailButton.layer.cornerRadius = 10;
    likeDetailButton.layer.masksToBounds = YES;
    followDetailButton.layer.cornerRadius = 10;
    followDetailButton.layer.masksToBounds = YES;
    
    shader.layer.cornerRadius = 10;
    shader.layer.masksToBounds = YES;
    
    posterName.text = [NSString stringWithFormat:@"by %@",self.photo[@"username"]];
}

-(void)queryAll
{
    [self queryComments];
    [self queryLikes];
    [self queryFollowing];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)onLikeButtonPressed:(id)sender
{
    PFObject* like = [PFObject objectWithClassName:@"Like"];
    [like setObject:[PFUser currentUser][@"username"] forKey:@"username"];
    [like setObject:self.photo forKey:@"photo"];
    [like saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self queryLikes];
    }];
}

-(void)queryLikes
{
    PFQuery *query = [PFQuery queryWithClassName:@"Like"];
    [query whereKey:@"photo" equalTo:self.photo];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        likeLabel.text = [NSString stringWithFormat:@"%i",objects.count];
    }];
}

- (IBAction)onFollowButtonPressed:(id)sender
{
    PFObject* following = [PFObject objectWithClassName:@"Following"];
    [following setObject:[PFUser currentUser][@"username"] forKey:@"userFollowing"];
    [following setObject:self.photo[@"username"] forKey:@"userFollowed"];
    [following saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self queryFollowing];
    }];
}

-(void)queryFollowing
{
    PFQuery *query = [PFQuery queryWithClassName:@"Following"];
    [query whereKey:@"userFollowed" equalTo:self.photo[@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        followLabel.text = [NSString stringWithFormat:@"%i",objects.count];
    }];
}
- (IBAction)onPostButtonPressed:(id)sender
{
    [commentTextField resignFirstResponder];
    PFObject *newComment = [PFObject objectWithClassName:@"Comment"];
    [newComment setObject:[PFUser currentUser][@"username"] forKey:@"author"];
    [newComment setObject:self.photo forKey:@"photo"];
    [newComment setObject:commentTextField.text forKey:@"text"];
    
    [newComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self queryComments];
    }];
}

-(void)queryComments
{
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query whereKey:@"photo" equalTo:self.photo];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        comments = [[objects reverseObjectEnumerator] allObjects];
        [commentTable reloadData];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"commentReuseID"];
    PFObject *comment = [comments objectAtIndex:indexPath.row];
    cell.textLabel.text = [comment objectForKey:@"text"];
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    NSString* uploaded = [formatter stringFromDate:comment.createdAt];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"by %@, %@",comment[@"author"],uploaded];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return comments.count;
}

- (IBAction)onDoneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
