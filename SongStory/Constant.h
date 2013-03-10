//
//  Constant.h
//  SongStory
//
//  Created by Jiao Jingping on 3/10/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {kStateInit, kStatePause, kStateStop} PlayState;
@interface Constant : NSObject
extern NSString * const DEFAULT_PLAY_IMAGE;
extern NSString * const DEFAULT_PAUSE_IMAGE;
extern NSString * const DEFAULT_STOP_IMAGE;
extern NSString * const DEFAULT_PROGRESS_IMAGE;


@end
