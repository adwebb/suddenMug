//
//  TabController.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "TabController.h"
#import "ProfileViewController.h"
#import "SearchViewController.h"
#import "FeedViewController.h"
#import "CameraViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface TabController () <UITabBarDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{
    LoginViewController *login;
    User* currentUser;
    UIImagePickerController* ipc;
    CameraViewController* cvc;
}
@end

@implementation TabController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ipc = [UIImagePickerController new];
    cvc = self.viewControllers[2];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    if (![PFUser currentUser]) {
        login = [LoginViewController new];
        login.delegate = self;
        login.signUpController.delegate = self;
        UIImageView* logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
        login.logInView.logo = logo;
        
        [self presentViewController:login animated:animated completion:nil];
    }
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [logInController dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [signUpController dismissViewControllerAnimated:YES completion:nil];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if([item.title isEqualToString:@"Photo"])
    {
        UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose from Library", @"Take new photo", nil];
        [actionSheet showInView:self.view];
        
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  
    
    switch (buttonIndex) {
        case 0:
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [cvc presentViewController:ipc animated:YES completion:nil];
            }
            break;
        case 1:
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
                ipc.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                [cvc presentViewController:ipc animated:YES completion:nil];
            }
            break;
        default:
            break;
    }
}



@end
