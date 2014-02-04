//
//  CameraViewController.h
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "Comment.h"

@interface CameraViewController : UIViewController
@property Photo* photo;
@property Comment* initialComment;

@end

