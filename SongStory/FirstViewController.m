//
//  FirstViewController.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage* image1 = [UIImage imageNamed:@"cover1.jpg"];
    SongView* view1 = [SongView songViewWithImageAndRadius:image1 :100];
    
    SongModel* model1 = [SongModel songModelWith:@"Tylor Swift"
                                           Album:@"Fearkess"
                                           Title:@"Fearkess"
                                          Writer:@"Taylor Swift, Liz Rose, Hillary Lindsey"
                                             URL:@"music3.mp3"];
    SongViewController *svc1 = [SongViewController songViewControllerWithViewAndModel:view1 Model:model1];
       
    UIImage* image2 = [UIImage imageNamed:@"cover2.jpg"];
    SongView* view2 = [SongView songViewWithImageAndRadius:image2 :100];
    
    SongModel* model2 = [SongModel songModelWith:@"Britney Spears"
                                           Album:@"Femme Fatale"
                                           Title:@"Till the World Ends"
                                            Writer:@"Lukasz Gottwald, Alexander"
                                             URL:@"music3.mp3"];
    
    SongViewController *svc2 = [SongViewController songViewControllerWithViewAndModel:view2 Model:model2];
    
    
    UIImage* image3 = [UIImage imageNamed:@"cover3.jpg"];
    SongView* view3 = [SongView songViewWithImageAndRadius:image3 :100];
    
    SongModel* model3 = [SongModel songModelWith:@"Keane"
                                           Album:@"Atlantic"
                                           Title:@"Under The Iron Sea"
                                          Writer:@"Andy Green, Keane"
                                             URL:@"music3.mp3"];
    
    SongViewController *svc3 = [SongViewController songViewControllerWithViewAndModel:view3 Model:model3];
   view1.center = CGPointMake(150,150);
    [self addSubControllerAndView:svc1 ToView:self.view];
    
    
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

@end
