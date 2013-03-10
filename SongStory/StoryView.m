//
//  StoryView.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "StoryView.h"

@implementation StoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
          StoryInfo:(UIView*)storyInfo
          StoryView:(UILabel*)storyView
           Comments:(UIView*)comments
{
    self = [super initWithFrame:frame];
    if (self) {
        self.storyInfo = storyInfo;
        self.storyView = storyView;
        self.comments = comments;
        
        [self addSubview:storyInfo];
        [self addSubview:storyView];
        [self addSubview:comments];
        
        self.frame = CGRectMake(STORY_MARGIN,
                                50,
                                self.storyInfo.frame.size.width,
                                self.storyInfo.frame.size.height + self.storyView.frame.size.height + self.comments.frame.size.height);
    }
    
    return self;
}

@end
