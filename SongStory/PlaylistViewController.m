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
}
@synthesize songs;
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
    [self loadSongAtIndex:1];
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
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.panGesture setDelegate:self];
    [the_view addGestureRecognizer:self.panGesture];

}

- (void) nextSong {
    
}

- (void) loadSongAtIndex:(CGFloat)index {
    if ([songs count] > index) {
        SongModel * model = (SongModel*)[songs objectAtIndex:index];
        UIImage* image = [UIImage imageNamed:model.imageName];
        SongView* view = [SongView songViewWithImageAndRadius:image :100];
        SongViewController *svc = [SongViewController songViewControllerWithViewAndModel:view Model:model];
        view.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
        [self addSubControllerAndView:svc ToView:self.view];
        [self addGestureRecognizersToView:self.view];
        curSong = index;
    }
}

- (void) lastSong {

}

- (void) pan:(UIPanGestureRecognizer *)gesture {
    NSLog(@"Pan",nil);
    CGPoint velocity = [gesture velocityInView:self.view];
}
@end
