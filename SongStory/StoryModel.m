//
//  StoryModel.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "StoryModel.h"

@implementation StoryModel

- (id) initWithUser:(User*)user
              Story:(NSString*)story
          LikeCount:(NSInteger)count
           Comments:(NSArray*)comments
{
    if (self = [self init]) {
        
        self.user = user;
        self.story = story;
        self.likeCount = count;
        self.comments = comments;
        self.createTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    }
    
    return self;
}

@end
