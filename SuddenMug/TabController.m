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
#import "LoginViewController.h"

@interface TabController () <UITabBarDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>
{
    User* currentUser;
    UIImagePickerController* cvc;
}
@end

@implementation TabController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//    if(currentUser == nil)
//    {
//        [self performSegueWithIdentifier:@"LoginSegue" sender:self];
//    }
    
    cvc = [UIImagePickerController new];
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
                cvc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:cvc animated:YES completion:nil];
            }
            break;
        case 1:
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                cvc.sourceType = UIImagePickerControllerSourceTypeCamera;
                cvc.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                [self presentViewController:cvc animated:YES completion:nil];
            }
            break;
        default:
            break;
    }
    
    
}

@end
