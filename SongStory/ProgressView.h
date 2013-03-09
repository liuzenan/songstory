//
//  ProgressView.h
//  SongStory
//
//  Created by Jiao Jingping on 3/10/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CoreAnimation.h>

@interface ProgressView : UIView
@property (nonatomic) CGFloat percent;
@property (nonatomic) CGFloat radius;
+ (ProgressView*) progressViewWithRadius:(CGFloat)radius ;
@end
