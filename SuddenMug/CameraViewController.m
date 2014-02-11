//
//  CameraViewController.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "CameraViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import "Parse/Parse.h"

@interface CameraViewController () <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
{
    __weak IBOutlet UIImageView *reviewImageView;
    __weak IBOutlet UITextField *commentField;
    __weak IBOutlet UIButton *postButton;
    
    UIImagePickerController* ipc;
    PFObject* image;
}

@end

@implementation CameraViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    ipc = [UIImagePickerController new];
    ipc.delegate = self;
    commentField.background = [UIImage imageNamed:@"textfield"];
    commentField.font = [UIFont fontWithName:@"DKCrayonCrumble" size:18];
    [postButton.titleLabel setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    [postButton setBackgroundImage:[UIImage imageNamed:@"buttons"] forState:UIControlStateNormal];
    [postButton setBackgroundImage:[UIImage imageNamed:@"buttonsPressed"] forState:UIControlStateHighlighted];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    reviewImageView.layer.cornerRadius = 10;
    reviewImageView.layer.masksToBounds = YES;
    reviewImageView.image = nil;
    commentField.text = @"";
    
}
- (IBAction)onPostButtonPressed:(id)sender
{
    [commentField resignFirstResponder];
    if(image)
    {
    if(![commentField.text isEqualToString:@""])
         {
             PFObject* newComment = [PFObject objectWithClassName:@"Comment"];
             [newComment setObject:[PFUser currentUser][@"username"] forKey:@"author"];
             [newComment setObject:image forKey:@"photo"];
             [newComment setObject:commentField.text forKey:@"text"];
             [newComment saveInBackground];
         }
        [image saveInBackground];
    }else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Post what?" message:@"Select or take a photo first!" delegate:self cancelButtonTitle:@"If you say so..." otherButtonTitles:nil];
            [alert show];
        }
}

-(void)getImageFromLibrary
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.allowsEditing = YES;
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

-(void)getImageFromCamera
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        ipc.allowsEditing = YES;
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self textFieldShouldReturn:textField];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage* photoImage = info[UIImagePickerControllerEditedImage];
    CGSize resize = CGSizeMake(280, 280);
    UIGraphicsBeginImageContextWithOptions(resize, NO, 0.0);
    [photoImage drawInRect:CGRectMake(0, 0, resize.width, resize.height)];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData* imageData = UIImagePNGRepresentation(resizedImage);
        
                             
        PFUser* user = [PFUser currentUser];
        [user fetchIfNeeded];
        
        image = [PFObject objectWithClassName:@"Photo"];
        image[@"image"] = [PFFile fileWithData:imageData];
        image[@"user"] = user;
        image[@"username"] = user[@"username"];
        
        reviewImageView.image = info[UIImagePickerControllerEditedImage];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    
}

@end
