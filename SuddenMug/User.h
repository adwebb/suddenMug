//
//  User.h
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

@interface User : NSObject
@property PFUser* parseUser;
@property NSMutableArray* photos;
@property NSMutableArray* followings;
@property NSMutableArray* followers;
@property NSDate* timeStamp;
@end
