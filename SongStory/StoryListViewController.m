//
//  StoryListViewController.m
//  SongStory
//
//  Created by Zenan on 10/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "StoryListViewController.h"

@interface StoryListViewController ()

@end

@implementation StoryListViewController

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
    UIScrollView *outerScroll = (UIScrollView*)self.view;
    outerScroll.showsVerticalScrollIndicator = NO;
    outerScroll.showsHorizontalScrollIndicator = NO;

}

- (void)loadView
{
    NSMutableArray *stories = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        StoryViewController *story = [[StoryViewController alloc] initWithName:@"Liu Zenan" LikeCount:12 Story:@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum!" Comments:nil];
        [stories addObject:story];
    }
    
    NSUInteger count = [stories count];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIScrollView *outerScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    outerScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    outerScroll.contentSize = CGSizeMake(count * screenRect.size.width, outerScroll.frame.size.height - 49);
    outerScroll.pagingEnabled = YES;
    outerScroll.showsHorizontalScrollIndicator = NO;
    outerScroll.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < count; i++) {
        StoryViewController *story = [stories objectAtIndex:i];
        story.view.frame = CGRectMake(i * screenRect.size.width, 0, story.view.frame.size.width, story.view.frame.size.height);
        [outerScroll addSubview:story.view];
    }
    
    self.view = outerScroll;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
