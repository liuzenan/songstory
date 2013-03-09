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
@property (nonatomic,strong) UIImageView *controlImage;

@end

typedef enum {kStatePlay, kStatePause} PlayState;

@implementation SongViewController {
    BOOL isClockWise;
}
@synthesize songview,songmodel,timer,avPlayer,controlImage;
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
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], songmodel.url]];
        NSData *memoData = [NSData dataWithContentsOfURL:url];
        self.avPlayer = [[AVAudioPlayer alloc] initWithData:memoData error:nil];
    }
    return self;
}

- (void)addStateImage:(PlayState)state {
    if (controlImage) {
        [controlImage removeFromSuperview];
        controlImage = nil;
    }
    
    if (state == kStatePlay) {
        controlImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:DEFAULT_PLAY_IMAGE]];
    } else if (state == kStatePause) {
        controlImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:DEFAULT_PAUSE_IMAGE]];
    }
    
    [self.view addSubview:controlImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addGestureRecognizersToView:songview];
    [self addStateImage:kStatePlay];
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
    if (timer) {
        [self stop];
        
    } else {
        [self play];
    }
}

- (void) stop {
    [self addStateImage:kStatePause];
    [avPlayer stop];
    [self stopRotate];
}

- (void)play
{
   
    [self startRotate];
    [avPlayer prepareToPlay];
    [avPlayer play];
}
@end
