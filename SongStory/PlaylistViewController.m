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
extern CGFloat const DEFAULT_SONG_VIEW_RADIUS;
extern CGFloat const DEFAULT_SONG_VIEW_SEPERATION;
@end

@implementation PlaylistViewController {
    SongViewController *curSongController;
    int curSongIndex;
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

	// Do any additional setup after loading the view.
    NSLog(@"playlist view load");
    StoryListViewController *storyList = [[StoryListViewController alloc] init];
    self.storyList = storyList;
     //[self.view addSubview:self.storyList.view];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self loadSongModels];
    [self loadSongs];
   
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
    
    for (int i = 0; i < [songs count]; i++) {
        [self loadSongAtIndex:i];
    }
    
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CGFloat scrollViewWidth = [songs count] * [UIScreen mainScreen].bounds.size.width;
    [scrollView setContentSize:CGSizeMake(scrollViewWidth,scrollView.frame.size.height - 49)];
    
    

}


- (void) loadSongAtIndex:(CGFloat)index {
    SongModel * model = (SongModel*)[songs objectAtIndex:index];
    UIImage* image = [UIImage imageNamed:model.imageName];
    SongView* view = [SongView songViewWithImageAndRadius:image :DEFAULT_SONG_VIEW_RADIUS];
    SongViewController *svc = [SongViewController songViewControllerWithViewAndModel:view Model:model];
    view.center = CGPointMake(self.view.center.x + index * [UIScreen mainScreen].bounds.size.width, self.view.center.y - DEFAULT_SONG_VIEW_RADIUS / 2);
    svc.delegate = self;
    [self addSubControllerAndView:svc ToView:self.view];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)p_scrollView {
    
    int delta = 100;
    int curIndex = p_scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    if (curSongIndex != curIndex) {
        curSongIndex = curIndex;
        if (curSongIndex - 1 >= 0) {
            SongViewController *lastSVC = (SongViewController*)[self.childViewControllers objectAtIndex:curSongIndex - 1];
            lastSVC.songview.transform =CGAffineTransformTranslate(lastSVC.songview.transform, delta, 0);
        }
        
        if (curSongIndex + 1 <= [songs count]) {
            SongViewController *nextSVC = (SongViewController*)[self.childViewControllers objectAtIndex:curSongIndex + 1];
            nextSVC.songview.transform =CGAffineTransformTranslate(nextSVC.songview.transform, -delta, 0);
        }
    }
    NSLog(@"%d",curSongIndex);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)p_scrollView {
    int delta = 100;
    int curIndex = p_scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    if (curSongIndex != curIndex) {
        //curSongIndex = curIndex;
        if (curSongIndex - 1 >= 0) {
            SongViewController *lastSVC = (SongViewController*)[self.childViewControllers objectAtIndex:curSongIndex - 1];
            lastSVC.songview.transform =CGAffineTransformTranslate(lastSVC.songview.transform, -delta, 0);
        }
        
        if (curSongIndex + 1 <= [songs count]) {
            SongViewController *nextSVC = (SongViewController*)[self.childViewControllers objectAtIndex:curSongIndex + 1];
            nextSVC.songview.transform =CGAffineTransformTranslate(nextSVC.songview.transform, +delta, 0);
        }
    }

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
