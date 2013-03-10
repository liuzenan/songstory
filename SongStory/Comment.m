//
//  Comment.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "Comment.h"

@implementation Comment

- (id) initWithUser:(User*)user Comment:(NSString*)comment CurrentTime:(NSDate*)commentTime
{
    if (self = [self init]) {
        self.user = user;
        self.comment = comment;
        self.commentTime = commentTime;
    }
    
    return self;
}

@end
