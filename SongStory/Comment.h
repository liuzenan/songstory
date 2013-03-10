//
//  Comment.h
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Comment : NSObject

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSDate *commentTime;

@end
