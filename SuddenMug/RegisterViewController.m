//
//  RegisterViewController.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/4/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

-(void)viewDidLayoutSubviews
{
    self.signUpView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"purplebg"]];
    [self.signUpView.dismissButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.signUpView.dismissButton setImage:[UIImage imageNamed:@"closePressed"] forState:UIControlStateHighlighted];
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"buttons"] forState:UIControlStateNormal];
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"buttonsPressed"] forState:UIControlStateHighlighted];
    [self.signUpView.usernameField setBackground:[UIImage imageNamed:@"textfield"]];
    [self.signUpView.passwordField setBackground:[UIImage imageNamed:@"textfield"]];
    [self.signUpView.emailField setBackground:[UIImage imageNamed:@"textfield"]];

    [self.signUpView.signUpButton.titleLabel setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    [self.signUpView.signUpButton setTitleColor:[UIColor colorWithRed:1.0 green:198/255.0 blue:0.0 alpha:1] forState:UIControlStateNormal];
    [self.signUpView.usernameField setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    [self.signUpView.passwordField setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    [self.signUpView.emailField setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    [self.signUpView.usernameField setTextColor:[UIColor darkTextColor]];
    [self.signUpView.passwordField setTextColor:[UIColor darkTextColor]];
    [self.signUpView.emailField setTextColor:[UIColor darkTextColor]];
    
}

@end
