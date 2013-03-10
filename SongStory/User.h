//
//  User.h
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *profile;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, readonly) NSInteger *userID;

- (id) initWithName:(NSString*)name;

@end
