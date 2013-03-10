//
//  StoryModel.h
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface StoryModel : NSObject

@property (nonatomic, assign) NSString *story;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) User *user;


- (id) initWithUser:(User*)user
              Story:(NSString*)story
          LikeCount:(NSInteger)count
           Comments:(NSArray*)comments;

@end
