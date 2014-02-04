//
//  Comment.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "Comment.h"

@implementation Comment
@synthesize timeStamp;
-(id)init
{
    self = [super init];
    self.timeStamp = [NSDate date];
    return self;
}


@end
