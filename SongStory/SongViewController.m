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
extern CGFloat const UPDATE_INTERVAL;
@end


@implementation SongViewController {
    CGPoint lastPoint;
    UIView *informationBox;
}

CGFloat const UPDATE_INTERVAL = 0.01;

@synthesize songview,songmodel,timer,avPlayer,delegate;
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
        avPlayer.delegate = self;
    }
    return self;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self stop];
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
    if (avPlayer == nil || !avPlayer.playing) {
        return;
    }
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [songview showProgressBar];
        lastPoint = [gesture locationInView:gesture.view.superview];
        //Stop auto rotate
        [timer invalidate];
        timer = nil;
        return;
    } else if (gesture.state == UIGestureRecognizerStateEnded && timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_INTERVAL target:self selector:@selector(update) userInfo:nil repeats:YES];
        [self jumpTo:songview.progress.percent / 100.0];
    }
    CGPoint curPoint = [gesture locationInView:gesture.view.superview];
    CGFloat v1_x = lastPoint.x - gesture.view.center.x;
    CGFloat v1_y = lastPoint.y - gesture.view.center.y;
    
    CGFloat v2_x = curPoint.x - gesture.view.center.x;
    CGFloat v2_y = curPoint.y - gesture.view.center.y;
    
    CGFloat temp1 = (sqrt(v1_x * v1_x + v1_y * v1_y) * sqrt(v2_x * v2_x + v2_y * v2_y));
    CGFloat temp2 = (v1_x * v2_x + v1_y * v2_y);
    CGFloat angle = acosf(temp2 / temp1);
    
    CGPoint translate = [gesture translationInView:gesture.view.superview];
    if ((translate.x > 0 && curPoint.y < songview.center.y) || (translate.x < 0 && curPoint.y > songview.center.y)) {
        angle = angle;
        // Update progress bar clockwise
        [self changeProgress:0.5];
    } else {
        // Update progress bar anti-clockwise
        [self changeProgress:-0.5];
        angle = - angle;
    }
    gesture.view.transform = CGAffineTransformRotate(gesture.view.transform, angle);
    lastPoint = curPoint;
    [gesture setTranslation:CGPointMake(0, 0) inView:gesture.view];
}



- (void) startRotate {
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_INTERVAL target:self selector:@selector(update) userInfo:nil repeats:YES];
    }
}


- (void) stopRotate {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)update {
    [self rotateView];
    [self changeProgress:100 * UPDATE_INTERVAL/avPlayer.duration];
}

- (void) rotateView {
    songview.transform = CGAffineTransformRotate(songview.transform, M_PI / 1000);
}

- (void) singleTap:(UIRotationGestureRecognizer *)gesture {
    if (timer) {
        [self pause];
        
    } else {
        [self play];
    }
}

- (void) pause {
    [songview addStateImage:kStatePause];
    [avPlayer stop];
    [self stopRotate];
    [delegate didPausedPlaying:self];
}

- (void) stop {
    [songview addStateImage:kStateStop];
    [self setProgressPercent:0];
    [avPlayer stop];
    avPlayer.currentTime = -avPlayer.currentTime;
    [self stopRotate];
    [delegate didFinishedPlaying:self];
}

- (void)play
{
    [songview removeStateImage];
    [self startRotate];
    [avPlayer prepareToPlay];
    [avPlayer play];
    [delegate didStartedPlaying:self];
}


- (void) reinit {
    [songview addStateImage:kStateInit];
    songview.transform = CGAffineTransformMakeRotation(0.0);
    [self setProgressPercent:0];
    [avPlayer stop];
    avPlayer.currentTime = -avPlayer.currentTime;
    [self stopRotate];
    
}
- (void)jumpTo:(CGFloat)percent {
    if (percent < 0) {
        percent = 1 - percent;
    }
    avPlayer.currentTime = - avPlayer.currentTime;
    
    avPlayer.currentTime = avPlayer.duration * percent;
}

- (void) setProgressPercent:(CGFloat)p_percent{
    if (p_percent >= 0 && p_percent <= 100) {
        songview.progress.percent = p_percent;
        [songview.progress setNeedsDisplay];
    }
}


- (void) togglePlayView:(CGPoint)center :(CGAffineTransform)transform {
    
    if (songview.userInteractionEnabled == YES) {
        if (!informationBox) {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            informationBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 70)];
            informationBox.layer.borderWidth = 1.0f;
            informationBox.layer.borderColor = [UIColor colorWithWhite:0.7f alpha:0.8f].CGColor;
            informationBox.backgroundColor = [UIColor whiteColor];
            UILabel *songTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, screenRect.size.width - 80, 20)];
            songTitle.text = songmodel.title;
            [songTitle setFont:[UIFont fontWithName:@"Merriweather-Bold" size:18]];
            songTitle.textAlignment = NSTextAlignmentRight;
            
            UILabel *singerName = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, screenRect.size.width - 80, 16)];
            singerName.text = songmodel.artist;
            [singerName setFont:[UIFont fontWithName:@"Bariol" size:14]];
            singerName.textAlignment = NSTextAlignmentRight;
            
            [self.view.superview.superview insertSubview:informationBox belowSubview:self.view.superview];
            [informationBox addSubview:songTitle];
            [informationBox addSubview:singerName];
            informationBox.alpha = 0;
            
        }
        songview.userInteractionEnabled = NO;
        [UIView animateWithDuration:1.0
                         animations:^{
                             songview.circle.alpha = 0;
                             songview.middle.alpha = 0;
                             songview.controlImage.alpha = 0;
                             songview.progress.alpha = 0;
                             songview.transform = transform;
                             songview.center = center;
                             informationBox.alpha = 1;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
    } else {
        songview.userInteractionEnabled = YES;
        [UIView animateWithDuration:1.0
                         animations:^{
                             songview.circle.alpha = 1;
                             songview.middle.alpha = 1;
                             songview.controlImage.alpha = 1;
                             songview.progress.alpha = 1;
                             informationBox.alpha = 0;
                             songview.transform = transform;
                             songview.center = center;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];

    
    }
}

- (void)changeProgress:(CGFloat)delta
{
    if (songview.progress.percent + delta <= 100 && songview.progress.percent + delta >= 0) {
        // If we can decrement our percentage, do so, and redraw the view
        int temp = (songview.progress.percent + delta) / 100.0;
        songview.progress.percent = (songview.progress.percent + delta) - temp * 100.0;
        [songview.progress setNeedsDisplay];
    }
}

@end
