//
//  PlaylistViewController.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "PlaylistViewController.h"

@interface PlaylistViewController ()

@property (nonatomic,strong) NSMutableArray* songs;
@property (nonatomic,strong) UITapGestureRecognizer* singleTap;

extern CGFloat const DEFAULT_SONG_VIEW_RADIUS;
extern CGFloat const DEFAULT_SONG_VIEW_SEPERATION;
extern CGFloat const DEFAULT_MINIMIZED_VIEW_HEIGHT;
@end

@implementation PlaylistViewController {
    SongViewController *curSongController;
    BOOL isCommentMode;
    CGPoint lastCenter;
    CGAffineTransform lastTransform;
}

@synthesize songs,scrollView,playListTab,singleTap;

// Assume the part of next|last album expose p to the current system
// Then 2 * p * radius + 2 * radius + 2 * speration = UIScreen mainscreen].bounds.width
CGFloat const DEFAULT_SONG_VIEW_RADIUS = 100;
CGFloat const DEFAULT_SONG_VIEW_SEPERATION = 13;
CGFloat const DEFAULT_MINIMIZED_VIEW_HEIGHT = 50;



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
    
	// Do any additional setup after loading the view.
    NSLog(@"playlist view load");
    StoryListViewController *storyList = [[StoryListViewController alloc] init];
    self.storyList = storyList;
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"storybackground.png"]];
    scrollView.pagingEnabled = YES;
    [self loadSongModels];
    [self loadSongs];
    [self addGestureRecognizersToView:self.view];
}


- (void)addGestureRecognizersToView:(UIView *)the_view {
    
    the_view.userInteractionEnabled = YES;
    
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.singleTap setDelegate:self];
    [self.singleTap setNumberOfTapsRequired:1]; // double tap
    [the_view addGestureRecognizer:self.singleTap];
    
}

- (void)singleTap:(id)sender {
    NSLog(@"Tap",nil);
    SongViewController *curSVC = [self.childViewControllers objectAtIndex:[self getCurrentControllerIndex]];
    if (!isCommentMode) {
        for (SongViewController *svc in self.childViewControllers ) {
            if (svc != curSVC) {
                svc.songview.alpha = 0;
            }
        }
        
        [self.view addSubview:self.storyList.view];
        isCommentMode = YES;
        lastCenter = curSVC.view.center;
        lastTransform = curSVC.view.transform;
        CGFloat scale = DEFAULT_MINIMIZED_VIEW_HEIGHT / curSVC.songview.frame.size.height;
        CGAffineTransform transform = CGAffineTransformScale(curSVC.songview.transform, scale,scale);
        CGPoint center = CGPointMake(curSVC.view.frame.origin.x +
                                     curSVC.view.frame.size.width -
                                     DEFAULT_MINIMIZED_VIEW_HEIGHT /2 + 50, curSVC.view.frame.origin.y - 50);
        [curSVC togglePlayView:center :transform];
    } else {
        for (SongViewController *svc in self.childViewControllers ) {
            if (svc != curSVC) {
                svc.songview.alpha = 1;
            }
        }

        isCommentMode = NO;
        [self.storyList.view removeFromSuperview];
        [curSVC togglePlayView:lastCenter :lastTransform];
    }
}

- (void)toggleComment {

}

- (int) getCurrentControllerIndex {
    return (int)scrollView.contentOffset.x / scrollView.frame.size.width;
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

- (void) loadSongs {
    if ([songs count] == 0) {
        //TODO Tell user there is no song
        return;
    }
    scrollView.pagingEnabled = YES;
    scrollView.clipsToBounds = NO;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CGFloat width = DEFAULT_SONG_VIEW_RADIUS * 2 + DEFAULT_SONG_VIEW_SEPERATION;
    CGFloat delta = ([UIScreen mainScreen].bounds.size.width - width) / 2;
    scrollView.frame = CGRectMake(self.view.frame.origin.x + delta, self.view.frame.origin.y, width, self.view.frame.size.height - 49);
    [scrollView setContentSize:CGSizeMake(width * [songs count] ,scrollView.frame.size.height - DEFAULT_SONG_VIEW_RADIUS)];

    for (int i = 0; i < [songs count]; i++) {
        [self loadSongAtIndex:i];
    }
<<<<<<< HEAD
    
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CGFloat scrollViewWidth = [songs count] * [UIScreen mainScreen].bounds.size.width;
    [scrollView setContentSize:CGSizeMake(scrollViewWidth,scrollView.frame.size.height - 49)];
    
=======
>>>>>>> 487a3488f9d49583425f7f01fbe7a88190ba210f
}


- (void) loadSongAtIndex:(CGFloat)index {
    SongModel * model = (SongModel*)[songs objectAtIndex:index];
    UIImage* image = [UIImage imageNamed:model.imageName];
    SongView* view = [SongView songViewWithImageAndRadius:image :DEFAULT_SONG_VIEW_RADIUS];
    SongViewController *svc = [SongViewController songViewControllerWithViewAndModel:view Model:model];
<<<<<<< HEAD
    view.center = CGPointMake(self.view.center.x + index * [UIScreen mainScreen].bounds.size.width,
                              self.view.center.y - DEFAULT_SONG_VIEW_RADIUS / 2);
=======
    view.center = CGPointMake(scrollView.bounds.size.width / 2 + index * (scrollView.frame.size.width), scrollView.bounds.size.height / 2 - 40);
>>>>>>> 487a3488f9d49583425f7f01fbe7a88190ba210f
    svc.delegate = self;
    [self addSubControllerAndView:svc ToView:scrollView];
    
}




// SongPlayListDelegate methods
- (void) didStartedPlaying:(id)sender {
    SongViewController* cur_svc = (SongViewController*)sender;
    for (SongViewController *svc in self.childViewControllers) {
        if (svc != cur_svc) {
            [svc reinit];
        }
    }
}



- (void) didPausedPlaying:(id)sender {
    
}
- (void) didFinishedPlaying:(id)sender {
    
}
@end
