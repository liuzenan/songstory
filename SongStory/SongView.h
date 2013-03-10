//
//  SongView.h
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CoreAnimation.h>
#import "Constant.h"
#import "ProgressView.h"
@interface SongView : UIImageView

@property (nonatomic,strong) UIImageView *controlImage;
@property (nonatomic,strong) ProgressView *progress;

- (void)hideProgressBar;
- (void)showProgressBar;
+ (SongView*) songViewWithImageAndRadius:(UIImage*)image :(CGFloat)radius;
- (void)addStateImage:(PlayState)state;
- (void)removeStateImage;

@end
