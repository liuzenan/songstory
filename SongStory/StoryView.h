//
//  StoryView.h
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryViewConstants.h"

@interface StoryView : UIView

@property (nonatomic, strong) UIView *storyInfo;
@property (nonatomic, strong) UILabel *storyView;
@property (nonatomic, strong) UIView *comments;

- (id)initWithFrame:(CGRect)frame
          StoryInfo:(UIView*)storyInfo
          StoryView:(UILabel*)storyView
           Comments:(UIView*)comments;

@end
