//
//  PlaylistViewController.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "PlaylistViewController.h"

@interface PlaylistViewController ()
@property (nonatomic,strong) UIPanGestureRecognizer* panGesture;
@property (nonatomic,strong) NSMutableArray* songs;

@end

@implementation PlaylistViewController {
    int curSong;
    CGPoint panStartPoint;
}
@synthesize songs,scrollView;
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
    [self loadSongModels];
    [self loadSongs];
}
- (void) loadSongs {
    for (int i = 0;i < [songs count]; i++) {
        [self loadSongAtIndex:i];
    }
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
    
    //self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    //[self.panGesture setDelegate:self];
    //[the_view addGestureRecognizer:self.panGesture];

}

- (void) nextSong {
    if (curSong + 1 < [songs count]) {
        NSLog(@"Next",nil);
        //[self loadSongAtIndex:curSong + 1];
    }
}

- (void) loadSongAtIndex:(CGFloat)index {
    if ([songs count] > index) {
        SongModel * model = (SongModel*)[songs objectAtIndex:index];
        UIImage* image = [UIImage imageNamed:model.imageName];
        SongView* view = [SongView songViewWithImageAndRadius:image :100];
        SongViewController *svc = [SongViewController songViewControllerWithViewAndModel:view Model:model];
        view.center = CGPointMake(self.view.center.x + index * self.view.frame.size.width, self.view.center.y - 100);
        [self addSubControllerAndView:svc ToView:self.view];
        [self addGestureRecognizersToView:self.view];
        curSong = index;
    }
}

- (void) stopCurSong {
    
}

- (void) lastSong {
    NSLog(@"Last",nil);
    if (curSong - 1  >= 0) {
        //[self loadSongAtIndex:curSong - 1];
    }
}

- (void) pan:(UIPanGestureRecognizer *)gesture {
    //NSLog(@"Pan",nil);
    if (gesture.state == UIGestureRecognizerStateBegan) {
        panStartPoint = [gesture locationInView:self.view];
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint translate = [gesture translationInView:self.view];
        CGPoint curPoint = [gesture locationInView:self.view];
        CGFloat dist_x = (panStartPoint.x - curPoint.x);
        CGFloat dist_y = (panStartPoint.y - curPoint.y);
        CGFloat dist = sqrt(dist_x * dist_x + dist_y * dist_y);
        if (dist > self.view.frame.size.width / 4 && translate.x > 0) {
            [self nextSong];
        } else if (dist > self.view.frame.size.width / 4 && translate.x < 0) {
            [self lastSong];
        }
    }
}
@end
