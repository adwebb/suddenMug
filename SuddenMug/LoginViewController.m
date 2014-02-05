//
//  LoginViewController.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/4/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.signUpController = [RegisterViewController new];
    UIImageView* logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    self.signUpController.signUpView.logo = logo;
	// Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

-(void)viewDidLayoutSubviews
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    [self.logInView.passwordForgottenButton setBackgroundImage:[UIImage imageNamed:@"forgot"]forState:UIControlStateNormal];
    [self.logInView.dismissButton setImage:[UIImage imageNamed:@"close"] forState: UIControlStateNormal];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"buttons"] forState:UIControlStateNormal];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"buttons"] forState:UIControlStateNormal];
    [self.logInView.passwordForgottenButton setBackgroundImage:[UIImage imageNamed:@"forgotPressed"] forState:UIControlStateHighlighted];
    [self.logInView.dismissButton setImage:[UIImage imageNamed:@"closePressed"] forState: UIControlStateHighlighted];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"buttonsPressed"]forState:UIControlStateHighlighted];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"buttonsPressed"] forState:UIControlStateHighlighted];
    self.logInView.usernameField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textfield"]];
    self.logInView.passwordField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textfield"]];
    
    [self.logInView.signUpButton.titleLabel setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    [self.logInView.signUpButton setTitleColor:[UIColor colorWithRed:0.0 green:198/255.0 blue:11/255.0 alpha:1] forState:UIControlStateNormal];
    [self.logInView.logInButton.titleLabel setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    [self.logInView.logInButton setTitleColor:[UIColor colorWithRed:0.0 green:144/255.0 blue:1.0 alpha:1] forState:UIControlStateNormal];
    
    [self.logInView.usernameField setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    [self.logInView.passwordField setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    [self.logInView.usernameField setTextColor:[UIColor darkTextColor]];
    [self.logInView.passwordField setTextColor:[UIColor darkTextColor]];
}

@end
