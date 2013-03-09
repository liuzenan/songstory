//
//  SongView.h
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CoreAnimation.h>
@interface SongView : UIImageView
+ (SongView*) songViewWithImageAndRadius:(UIImage*)image :(CGFloat)radius;
@end
