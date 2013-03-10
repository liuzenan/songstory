//
//  User.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "User.h"

@implementation User

- (id) initWithName:(NSString*)name
{
    if (self = [self init]) {
        self.name = name;
        self.profile = [UIImage imageNamed:@"user1.jpg"];
    }
    
    return self;
}

@end
