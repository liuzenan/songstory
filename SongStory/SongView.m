//
//  SongView.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "SongView.h"

@implementation SongView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (SongView*) songViewWithImageAndRadius:(UIImage*)image :(CGFloat)radius {
    SongView* inst = [[SongView alloc] initWithImage:image];
    inst.frame = CGRectMake(0, 0, 2*radius, 2*radius);
    inst.layer.cornerRadius = radius;
    inst.layer.masksToBounds = YES;
    inst.layer.borderColor = [UIColor lightGrayColor].CGColor;
    inst.layer.borderWidth = 1;
    
    UIView *middle = [[UIView alloc] initWithFrame:CGRectMake(inst.center.x, inst.center.y, radius / 2, radius / 2)];
    middle.layer.cornerRadius = radius / 4;
    middle.backgroundColor = [UIColor whiteColor];
    middle.layer.borderColor = [UIColor lightGrayColor].CGColor;
    middle.layer.borderWidth = 1;
    middle.alpha = 0.9;
    middle.center = inst.center;
    
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(inst.center.x, inst.center.y, radius / 1.5, radius / 1.5)];
    circle.layer.cornerRadius = radius / 3;
    circle.layer.borderColor = [UIColor lightGrayColor].CGColor;
    circle.layer.borderWidth = 3;
    circle.alpha = 0.5;
    circle.center = inst.center;
    
    [inst addSubview:circle];
    [inst addSubview:middle];
    return inst;
}



@end
