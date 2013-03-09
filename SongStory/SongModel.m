//
//  SongModel.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "SongModel.h"

@implementation SongModel
@synthesize album,artist,title,writer,url;

- (id) init:(NSString*)p_artist Album:(NSString*)p_album Title:(NSString*)p_title Writer:(NSString*)p_writer URL:(NSString*)p_url  {
    if (self = [super init]) {
        album = p_album;
        artist = p_artist;
        title = p_title;
        url = p_url;
        writer = p_writer;
    }
    return self;
}

+(SongModel *)songModelWith:(NSString*)artist Album:(NSString*)album Title:(NSString*)title Writer:(NSString*)writer URL:(NSString*)url  {
    return [[SongModel alloc] init:artist Album:album Title:title Writer:writer URL:url];
}
@end
