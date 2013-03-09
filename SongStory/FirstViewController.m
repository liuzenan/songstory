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
    UIImage* image = [UIImage imageNamed:@"cover1.jpg"];
    SongView* view = [SongView songViewWithImageAndRadius:image :100];
   
   
    SongModel* model = [[SongModel alloc] init];
    SongViewController *svc = [SongViewController songViewControllerWithViewAndModel:view Model:model];
    [self addSubControllerAndView:svc ToView:self.view];
    
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
