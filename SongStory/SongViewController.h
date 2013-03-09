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
#import "SongView.h"
#import "SongModel.h"
#import "Constant.h"
@interface SongViewController : UIViewController  <UIGestureRecognizerDelegate>

@property (nonatomic,weak) SongView* songview;
@property (nonatomic,strong) SongModel* songmodel;
@property (nonatomic,strong) AVAudioPlayer * avPlayer;
+ (SongViewController*) songViewControllerWithViewAndModel:(SongView*)songview Model:(SongModel*)songmodel;
@end
