//
//  PhotoViewCell.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/5/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "PhotoViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation PhotoViewCell
{
    UIView* shader;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
            }
    return self;
}

- (void)layoutSubviews {
    [self.imageView setFrame:self.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = 10;
    self.imageView.layer.masksToBounds = YES;
    
    
    if(!shader)
    {
        shader = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-(self.bounds.size.height/5), self.bounds.size.width, self.bounds.size.height/5)];
    }
    
    shader.alpha = .5;
    shader.backgroundColor = [UIColor blackColor];
    shader.layer.cornerRadius = 10;
    shader.layer.masksToBounds = YES;
    [self.contentView insertSubview:shader belowSubview:self.textLabel];
    
    [self.textLabel setFrame:CGRectMake(10, 230, 200, 30.0)];
    [self.textLabel setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
    [self.textLabel setTextColor:[UIColor whiteColor]];
    [self.detailTextLabel setFrame:CGRectMake(125, 250, 150, 30)];
    [self.detailTextLabel setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:18]];
 
    self.detailTextLabel.textColor = [UIColor whiteColor];
    self.detailTextLabel.textAlignment = NSTextAlignmentRight;

    self.contentView.frame = self.bounds;
}

@end
