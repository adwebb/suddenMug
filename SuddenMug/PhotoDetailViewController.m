//
//  PhotoDetailViewController.m
//  SuddenMug
//
//  Created by Fletcher Rhoads on 2/5/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()

@end

@implementation PhotoDetailViewController
{
    
    __weak IBOutlet PFImageView *thumbnailImageView;
    __weak IBOutlet UITextField *commentTextField;
    __weak IBOutlet UILabel *followLabel;
    __weak IBOutlet UILabel *likeLabel;
    __weak IBOutlet UILabel *posterName;
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

- (IBAction)onDoneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    thumbnailImageView.file = self.photo[@"image"];
    [thumbnailImageView loadInBackground];
}

@end
