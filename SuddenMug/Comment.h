//
//  Comment.h
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Comment : NSObject
@property NSString* text;
@property User* owner;
@property NSDate* timeStamp;
@end
