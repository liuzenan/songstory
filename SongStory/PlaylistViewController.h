//
//  PlaylistViewController.h
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryListViewController.h"
#import "SongViewController.h"
#import "SongPlayListDelegate.h"

@interface PlaylistViewController : UIViewController <SongPlayListDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITabBarItem *playListTab;
@property (nonatomic, strong) StoryListViewController *storyList;
@end
