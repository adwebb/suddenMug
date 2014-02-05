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
    
}
- (IBAction)onPostButtonPressed:(id)sender
{
    [commentField resignFirstResponder];
    if(image)
    {
    if(![commentField.text isEqualToString:@""])
         {
             image[@"Comment"] = commentField.text;
             [image saveInBackground];
         }
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
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

-(void)getImageFromCamera
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.cameraDevice = UIImagePickerControllerCameraDeviceFront;
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
    NSURL* url = info[UIImagePickerControllerReferenceURL];
    
    [[ALAssetsLibrary new] assetForURL:url resultBlock:^(ALAsset *asset) {
        NSUInteger const N = (NSUInteger)asset.defaultRepresentation.size;
        uint8_t bytes[N];
        [asset.defaultRepresentation getBytes:bytes fromOffset:0 length:N error:nil];
        NSData* data = [NSData dataWithBytes:bytes length:N];
        
        PFUser* user = [PFUser currentUser];
        [user fetchIfNeeded];
        
        image = [PFObject objectWithClassName:@"Photo"];
        image[@"image"] = [PFFile fileWithData:data];
        image[@"user"] = user;
        image[@"username"] = user[@"username"];
        
        reviewImageView.image = info[UIImagePickerControllerOriginalImage];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Max is a hobbit");
    }];
}

@end
