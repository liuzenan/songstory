//
//  SongViewController.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "SongViewController.h"

@interface SongViewController ()

@property (nonatomic,strong) UIPanGestureRecognizer * panGesture;
@property (nonatomic,strong) UITapGestureRecognizer * tapGesture;
@property (nonatomic,strong) NSTimer * timer;

@end

@implementation SongViewController {
    BOOL isClockWise;
}
@synthesize songview,songmodel,timer;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithViewAndModel:(SongView*) v Model:(SongModel*)m {
    if (self = [super init]) {
        self.songview = v;
        self.songmodel = m;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addGestureRecognizersToView:songview];
}

- (void)loadView {
    self.view = songview;
}

+ (SongViewController*) songViewControllerWithViewAndModel:(SongView*)songview Model:(SongModel*)songmodel {
    return [[SongViewController alloc] initWithViewAndModel:songview Model:songmodel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addGestureRecognizersToView:(UIView *)the_view {
    
    the_view.userInteractionEnabled = YES;
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.panGesture setDelegate:self];
    [the_view addGestureRecognizer:self.panGesture];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.tapGesture setDelegate:self];
    [self.tapGesture setNumberOfTapsRequired:1]; // double tap
    [the_view addGestureRecognizer:self.tapGesture];
    
}

- (void) pan:(UIPanGestureRecognizer *)gesture {
    NSLog(@"Pan",nil);
    [gesture setTranslation:CGPointMake(0, 0) inView:gesture.view.superview];
}



- (void) startRotate {
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rotateView) userInfo:nil repeats:YES];
    }
}


- (void) stopRotate {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void) rotateView {
    if (isClockWise) {
        songview.transform = CGAffineTransformRotate(songview.transform, -M_PI / 800);
    } else {
        songview.transform = CGAffineTransformRotate(songview.transform, M_PI / 800);
    }
}

- (void) singleTap:(UIRotationGestureRecognizer *)gesture {
    NSLog(@"tap",nil);
    if (timer) {
        [self stopRotate];
    } else {
        [self startRotate];
    }
}

@end
