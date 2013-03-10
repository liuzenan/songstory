//
//  SongModel.h
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongModel : NSObject
@property NSString *artist;
@property NSString *title;
@property NSString *album;
@property NSString *url;
@property NSString *writer;
@property NSString *imageName;

+(SongModel *)songModelWith:(NSString*)artist
                      Album:(NSString*)album
                      Title:(NSString*)title
                     Writer:(NSString*)writer
                  ImageName:(NSString*)image
                        URL:(NSString*)url;
@end
