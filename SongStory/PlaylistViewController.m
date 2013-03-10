//
//  PlaylistViewController.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "PlaylistViewController.h"

@interface PlaylistViewController ()
@property (nonatomic,strong) UISwipeGestureRecognizer* rightSwipeGesture;
@property (nonatomic,strong) UISwipeGestureRecognizer* leftSwipeGesture;

@property (nonatomic,strong) NSMutableArray* songs;
extern CGFloat const DEFAULT_SONG_VIEW_RADIUS;
extern CGFloat const DEFAULT_SONG_VIEW_SEPERATION;

@end

@implementation PlaylistViewController {
    int curSong;
    SongViewController *curSongController;
    CGPoint panStartPoint;
}
@synthesize songs,scrollView,playListTab;
CGFloat const DEFAULT_SONG_VIEW_RADIUS = 100.0;
CGFloat const DEFAULT_SONG_VIEW_SEPERATION = 10.0;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView.pagingEnabled = YES;
    [self loadSongModels];
    [self loadSongs];
    //[self addGestureRecognizersToView:scrollView];
}

- (void) loadSongModels {
    SongModel* model1 = [SongModel songModelWith:@"Tylor Swift"
                                           Album:@"Fearkess"
                                           Title:@"Fearkess"
                                          Writer:@"Taylor Swift, Liz Rose, Hillary Lindsey"
                                       ImageName:@"cover1.jpg"
                                             URL:@"music3.mp3"];
    
    
    SongModel* model2 = [SongModel songModelWith:@"Britney Spears"
                                           Album:@"Femme Fatale"
                                           Title:@"Till the World Ends"
                                          Writer:@"Lukasz Gottwald, Alexander"
                                       ImageName:@"cover2.jpg"
                                             URL:@"music3.mp3"];
    
    SongModel* model3 = [SongModel songModelWith:@"Keane"
                                           Album:@"Atlantic"
                                           Title:@"Under The Iron Sea"
                                          Writer:@"Andy Green, Keane"
                                       ImageName:@"cover3.jpg"
                                             URL:@"music3.mp3"];
    
    songs = [NSMutableArray array];
    [songs addObject:model1];
    [songs addObject:model2];
    [songs addObject:model3];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSubControllerAndView:(UIViewController *)subcontroller ToView:(UIView*) view{
    [self addChildViewController:subcontroller];
    [view addSubview:subcontroller.view];
    [subcontroller didMoveToParentViewController:self];
}

- (void)addGestureRecognizersToView:(UIView *)the_view {
    
    the_view.userInteractionEnabled = YES;
    
    self.rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [self.rightSwipeGesture setNumberOfTouchesRequired:1];
    [self.rightSwipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.rightSwipeGesture setDelegate:self];
    [the_view addGestureRecognizer:self.rightSwipeGesture];
    
    self.leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [self.leftSwipeGesture setNumberOfTouchesRequired:1];
    [self.leftSwipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.leftSwipeGesture setDelegate:self];
    [the_view addGestureRecognizer:self.leftSwipeGesture];

}

- (void) loadSongs {
    if ([songs count] == 0) {
        //TODO Tell user there is no song
        return;
    }
    
    for (int i = 0; i < [songs count]; i++) {
        [self loadSongAtIndex:i];
    }

    //CGRect screenFrame = [UIScreen mainScreen].bounds;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CGFloat scrollViewWidth = [songs count] * [UIScreen mainScreen].bounds.size.width;
    [scrollView setContentSize:CGSizeMake(scrollViewWidth,scrollView.frame.size.height - 49)];
}
- (void) nextSong {
     NSLog(@"Next",nil);
     /*
    if (curSong + 1 < [songs count]) {
        [curSongController isGoingToChange];
        for (SongViewController *svc in [self childViewControllers]) {
            CGPoint newCenter = CGPointMake(svc.songview.center.x - 2 * DEFAULT_SONG_VIEW_RADIUS + DEFAULT_SONG_VIEW_SEPERATION, svc.songview.center.y);
            [UIView animateWithDuration:0.5
                                  delay:0.0
                                options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                             animations:^{
                                 svc.songview.center  = newCenter;
                             }completion:^(BOOL finished){
                                 
            }];
        }
    }*/
}

- (void) lastSong {
    NSLog(@"Last",nil);
    /*
    if (curSong - 1  >= 0) {
        [curSongController isGoingToChange];
        for (SongViewController *svc in [self childViewControllers]) {
            CGPoint newCenter = CGPointMake(svc.songview.center.x + 2 * DEFAULT_SONG_VIEW_RADIUS + DEFAULT_SONG_VIEW_SEPERATION, svc.songview.center.y);
            [UIView animateWithDuration:0.5
                                  delay:0.0
                                options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                             animations:^{
                                 svc.songview.center  = newCenter;
                             }completion:^(BOOL finished){
                                 
                             }];
        }

    }*/
}

/*
- (void) loadSongViewAtIndexAsLastSong:(CGFloat)index {
    SongModel * model = (SongModel*)[songs objectAtIndex:index];
    UIImage* image = [UIImage imageNamed:model.imageName];
    SongView* view = [SongView songViewWithImageAndRadius:image :DEFAULT_SONG_VIEW_WIDTH];
}

- (void) loadSongViewAtIndexAsNextSong:(CGFloat)index {
    
}*/
- (void) loadSongAtIndex:(CGFloat)index {
    
    // Load current song
    SongModel * model = (SongModel*)[songs objectAtIndex:index];
    UIImage* image = [UIImage imageNamed:model.imageName];
    SongView* view = [SongView songViewWithImageAndRadius:image :DEFAULT_SONG_VIEW_RADIUS];
    SongViewController *svc = [SongViewController songViewControllerWithViewAndModel:view Model:model];
    view.center = CGPointMake(self.view.center.x + index * [UIScreen mainScreen].bounds.size.width, self.view.center.y - DEFAULT_SONG_VIEW_RADIUS);
    [self addSubControllerAndView:svc ToView:self.view];
    curSong = index;
    curSongController = svc;
}


- (void) swipeRight:(UISwipeGestureRecognizer *)gesture {
    [self lastSong];
    
}
- (void) swipeLeft:(UISwipeGestureRecognizer *)gesture {
    [self nextSong];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
