//
//  SongPlayListDelegate.h
//  SongStory
//
//  Created by Jiao Jingping on 3/10/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SongPlayListDelegate <NSObject>
- (void) didStartedPlaying:(id)sender;
- (void) didPausedPlaying:(id)sender;
- (void) didFinishedPlaying:(id)sender;

@end
