//
//  SongView.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "SongView.h"


@interface SongView ()
@property (nonatomic) CGFloat radius;
@end
@implementation SongView
@synthesize controlImage,progress,radius;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)removeStateImage {
    if (controlImage) {
        [controlImage removeFromSuperview];
        controlImage = nil;
    }
}

- (void)setUpProgress {
    progress = [ProgressView progressViewWithRadius:radius];
    progress.frame = self.frame;
    progress.layer.cornerRadius = radius;
    progress.transform = CGAffineTransformMakeScale(1.1, 1.1);
    progress.alpha = 0.2;
    [self.superview insertSubview:progress belowSubview:self];
}

- (void)hideProgressBar {
    [UIView animateWithDuration:2
                          delay:5.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         progress.layer.opacity = 0.1;
                     }completion:^(BOOL finished){
                         
                     }];
}

- (void)showProgressBar {
    if (progress.alpha != 1) {
        [UIView animateWithDuration:1
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         progress.alpha = 0.8;
                     }completion:^(BOOL finished){
                         
                     }];
    
        [self hideProgressBar];
    }
}

- (void)addStateImage:(PlayState)state {
    if (state == kStateInit) {
        controlImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:DEFAULT_PLAY_IMAGE]];
        CGFloat scale = self.bounds.size.height / controlImage.bounds.size.height ;
        controlImage.transform = CGAffineTransformScale(controlImage.transform, scale / 8, scale / 8);
        controlImage.center = self.center;
        controlImage.alpha = 0.8;
        [self.superview addSubview:controlImage];
        
    } else if (state == kStatePause) {
        
        controlImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:DEFAULT_PAUSE_IMAGE]];
        CGFloat scale = self.bounds.size.height / controlImage.bounds.size.height ;
        controlImage.transform = CGAffineTransformScale(controlImage.transform, scale / 10, scale / 10);
        controlImage.center = self.center;
        [self.superview addSubview:controlImage];
        
    } else if (state == kStateStop) {
        
        controlImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:DEFAULT_STOP_IMAGE]];
        CGFloat scale = self.bounds.size.height / controlImage.bounds.size.height ;
        controlImage.transform = CGAffineTransformScale(controlImage.transform, scale / 8, scale / 8);
        controlImage.center = self.center;
        [self.superview addSubview:controlImage];
    }
}


- (id) initWithImageAndRadius:(UIImage *)image Radius:(CGFloat)p_radius {
    if(self = [super initWithImage:image]) {
        [self setUpProgress];
        radius = p_radius;
        self.frame = CGRectMake(0, 0, 2*radius, 2*radius);
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1.5;
        CALayer* shadowLayer = [CALayer layer];
        [self.layer addSublayer:shadowLayer];
      
        UIView *middle = [[UIView alloc] initWithFrame:CGRectMake(self.center.x, self.center.y, radius / 2, radius / 2)];
        middle.layer.cornerRadius = radius / 4;
        middle.backgroundColor = [UIColor whiteColor];
        middle.layer.borderColor = [UIColor lightGrayColor].CGColor;
        middle.layer.borderWidth = 1;
        middle.alpha = 1;
        middle.center = self.center;
        
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(self.center.x, self.center.y, radius / 1.5, radius / 1.5)];
        circle.layer.cornerRadius = radius / 3;
        circle.layer.borderColor = [UIColor lightGrayColor].CGColor;
        circle.layer.borderWidth = 3;
        circle.alpha = 0.7;
        circle.center = self.center;
        
        [self addSubview:circle];
        [self addSubview:middle];
    }
    return self;
}

+ (SongView*) songViewWithImageAndRadius:(UIImage*)image :(CGFloat)radius {
    SongView* inst = [[SongView alloc] initWithImageAndRadius:image Radius:radius];
    return inst;
}

- (void)didMoveToSuperview {
    [self addStateImage:kStateInit];
    [self setUpProgress];
}
@end
