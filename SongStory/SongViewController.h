//
//  SongViewController.h
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "SongPlayListDelegate.h"
#import "SongView.h"
#import "SongModel.h"
#import "Constant.h"
@interface SongViewController : UIViewController  <UIGestureRecognizerDelegate,AVAudioPlayerDelegate>
@property (nonatomic,weak) id<SongPlayListDelegate> delegate;
@property (nonatomic,weak) SongView* songview;
@property (nonatomic,strong) SongModel* songmodel;
@property (nonatomic,strong) AVAudioPlayer * avPlayer;
+ (SongViewController*) songViewControllerWithViewAndModel:(SongView*)songview Model:(SongModel*)songmodel;
- (void) stop;
- (void) pause;
- (void) play;
- (void) jumpTo:(CGFloat)percent;
- (void) reinit;
- (void) togglePlayView:(CGPoint)center :(CGAffineTransform)transform;
@end