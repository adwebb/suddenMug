//
//  PhotoDetailViewController.m
//  SuddenMug
//
//  Created by Fletcher Rhoads on 2/5/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation PhotoDetailViewController
{
    
    __weak IBOutlet PFImageView *thumbnailImageView;
    __weak IBOutlet UITextField *commentTextField;
    __weak IBOutlet UILabel *followLabel;
    __weak IBOutlet UILabel *likeLabel;
    __weak IBOutlet UILabel *posterName;
    __weak IBOutlet UITableView *commentTable;
    
    NSArray *comments;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)onLikeButtonPressed:(id)sender
{
    
}

- (IBAction)onFollowButtonPressed:(id)sender
{
    
}
- (IBAction)onPostButtonPressed:(id)sender
{
    [commentTextField resignFirstResponder];
    PFObject *newComment = [PFObject objectWithClassName:@"Comment"];
    [newComment setObject:[PFUser currentUser][@"username"] forKey:@"author"];
    [newComment setObject:self.photo forKey:@"photo"];
    [newComment setObject:commentTextField.text forKey:@"text"];
    
    [newComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self querySomething];
    }];
}

-(void)querySomething
{
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query whereKey:@"photo" equalTo:self.photo];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        comments = objects;
        [commentTable reloadData];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"commentReuseID"];
    PFObject *comment = [comments objectAtIndex:indexPath.row];
    cell.textLabel.text = [comment objectForKey:@"text"];
    cell.detailTextLabel.text = [comment objectForKey:@"author"];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    thumbnailImageView.file = self.photo[@"image"];
    [thumbnailImageView loadInBackground];
    [self querySomething];
}

@end
