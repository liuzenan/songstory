//
//  StoryViewController.h
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "StoryView.h"
#import "StoryModel.h"
#import "Comment.h"

@interface StoryViewController : UIViewController

@property (nonatomic, strong) StoryModel *storyModel;

- (id)initWithName:(NSString*)username LikeCount:(NSInteger)count Story:(NSString*)story Comments:(NSArray*)comments;

- (id)initWithStory:(NSString*)story
           Comments:(NSArray*)comments
          LikeCount:(NSInteger)count
               User:(User*)user
         CreateTime:(NSDate*)date;


@end
