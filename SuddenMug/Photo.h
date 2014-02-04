//
//  Photo.h
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface Photo : UIImage
@property User* owner;
@property NSArray* likes;
@property NSArray* comments;
@end
