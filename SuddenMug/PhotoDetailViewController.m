//
//  PhotoDetailViewController.m
//  SuddenMug
//
//  Created by Fletcher Rhoads on 2/5/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PhotoDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

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
    if(![self checkIfAlreadyLiking])
    {
    PFObject* like = [PFObject objectWithClassName:@"Like"];
    [like setObject:[PFUser currentUser][@"username"] forKey:@"username"];
    [like setObject:self.photo forKey:@"photo"];
    [like saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self queryLikes];
    }];
    }
}


-(void)queryLikes
{
    PFQuery *query = [PFQuery queryWithClassName:@"Like"];
    [query whereKey:@"photo" equalTo:self.photo];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        likeLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)objects.count];
    }];
}

-(BOOL)checkIfAlreadyLiking
{
    PFQuery* query = [PFQuery queryWithClassName:@"Like"];
    [query whereKey:@"photo" equalTo:self.photo];
    [query whereKey:@"username" equalTo:[PFUser currentUser][@"username"]];
    NSArray* objects = [query findObjects];
    
    if(objects.count > 0)
    {
        PFObject* like = objects.firstObject;
        [like deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self queryLikes];
        }];
        return YES;
    }else{
        return NO;
    }
}

- (IBAction)onFollowButtonPressed:(id)sender
{
    if(![self checkIfAlreadyFollowing])
    {
        PFObject* following = [PFObject objectWithClassName:@"Following"];
        [following setObject:[PFUser currentUser][@"username"] forKey:@"userFollowing"];
        [following setObject:self.photo[@"username"] forKey:@"userFollowed"];
        [following saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self queryFollowing];
    }];
    }
}

-(BOOL)checkIfAlreadyFollowing
{
    PFQuery* query = [PFQuery queryWithClassName:@"Following"];
    [query whereKey:@"userFollowed" equalTo:self.photo[@"username"]];
    [query whereKey:@"userFollowing" equalTo:[PFUser currentUser][@"username"]];
    NSArray* objects = [query findObjects];
    
    if(objects.count != 0)
    {
        PFObject* following = objects.firstObject;
        [following deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self queryFollowing];
        }];
        return YES;
    }else{
        return NO;
    }
}

-(void)queryFollowing
{
    PFQuery *query = [PFQuery queryWithClassName:@"Following"];
    [query whereKey:@"userFollowed" equalTo:self.photo[@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        followLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)objects.count];
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
    cell.textLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:19];
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    NSString* uploaded = [formatter stringFromDate:comment.createdAt];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"by %@, %@",comment[@"author"],uploaded];
    cell.detailTextLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:14];
    cell.detailTextLabel.alpha = .7;
    
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

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:commentTextField])
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 40) ? NO : YES;
    }
    return YES;
}


@end
