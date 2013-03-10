//
//  ProgressView.m
//  SongStory
//
//  Created by Jiao Jingping on 3/10/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView {
    CGFloat startAngle;
    CGFloat endAngle;
}
@synthesize radius;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    // Create our arc, with the correct angles
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:radius
                      startAngle:startAngle
                        endAngle:(endAngle - startAngle) * (_percent / 100.0) + startAngle
                       clockwise:YES];
    
    // Set the display for the path, and stroke it
    bezierPath.lineWidth = 15;
    [[UIColor blackColor] setStroke];
    [bezierPath stroke];
}

- (id) initWithRadius:(CGFloat)p_radius {
    if (self = [super init]) {
        startAngle = - (M_PI / 2);
        endAngle = startAngle + (M_PI * 2);
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        radius = p_radius;
    }
    return self;
}

+ (ProgressView*) progressViewWithRadius:(CGFloat)radius {
    return [[ProgressView alloc] initWithRadius:radius];
}


@end
