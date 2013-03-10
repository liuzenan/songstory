//
//  StoryViewController.m
//  SongStory
//
//  Created by Zenan on 9/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "StoryViewController.h"

@interface StoryViewController ()

@end

@implementation StoryViewController

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
    NSLog(@"view did load");

}

- (id)initWithName:(NSString*)username LikeCount:(NSInteger)count Story:(NSString*)story Comments:(NSArray*)comments
{
    if (self = [super init]) {
        self.storyModel = [[StoryModel alloc] initWithUser:[[User alloc] initWithName:username] Story:story LikeCount:count Comments:comments];
    }
    
    return self;
}

- (void)loadView
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat storyWidth = screenRect.size.width - 2 * STORY_MARGIN;
    
    UIView *storyInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, storyWidth, STORYINFO_HEIGHT)];
    UIImageView *profilePic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:USER1_IMAGE]];
    profilePic.frame = CGRectMake(STORY_MARGIN, STORY_MARGIN, 36, 36);
    CALayer *profilePicLayer = [profilePic layer];
    [profilePicLayer setMasksToBounds:YES];
    [profilePicLayer setCornerRadius:5.0];
    
    // profile name
    UILabel *profileName = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, storyWidth - 100, 20)];
    profileName.text = self.storyModel.user.name;
    [profileName setFont:[UIFont fontWithName:@"Bariol-Bold" size:18]];
    
    // create time
    UILabel *storyCreateTime = [[UILabel alloc] initWithFrame:CGRectMake(50, 24, storyWidth - 100, 20)];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    storyCreateTime.text = [dateFormatter stringFromDate:self.storyModel.createTime];
    [storyCreateTime setFont:[UIFont fontWithName:@"Bariol" size:12]];

    // like count
    UILabel *likeCount = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width - STORY_MARGIN - 50, 10, 50, 20)];
    likeCount.text = [NSString stringWithFormat:@"%d", self.storyModel.likeCount];
    [likeCount setFont:[UIFont fontWithName:@"Bariol" size:18]];
    
    UIImageView *heart = [[UIImageView alloc] initWithImage:[UIImage imageNamed:HEART_IMAGE]];
    heart.frame = CGRectMake(screenRect.size.width - STORY_MARGIN - 35, 5, 25, 25);
    
    [storyInfo addSubview:profilePic];
    [storyInfo addSubview:profileName];
    [storyInfo addSubview:storyCreateTime];
    [storyInfo addSubview:likeCount];
    [storyInfo addSubview:heart];
    
    UILabel *storyTextView = [[UILabel alloc] initWithFrame:CGRectMake(5, STORYINFO_HEIGHT + 10, storyWidth-5, 0)];
    storyTextView.text = self.storyModel.story;
    [storyTextView setFont:[UIFont fontWithName:@"Bariol" size:14]];
    UIFont *font = storyTextView.font;
    CGSize constraintSize = CGSizeMake(storyTextView.frame.size.width, MAXFLOAT);
    storyTextView.adjustsFontSizeToFitWidth = NO;
    storyTextView.numberOfLines = 0;
    CGSize labelSize = [storyTextView.text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    storyTextView.frame = CGRectMake(storyTextView.frame.origin.x,
                                     storyTextView.frame.origin.y,
                                     storyTextView.frame.size.width,
                                     labelSize.height);
    
    
    if (self.storyModel.comments) {
        for (Comment *comment in self.storyModel.comments) {
            UIView *commentItem  = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                            storyTextView.frame.origin.y + storyTextView.frame.size.height + 10,
                                                                            storyWidth,
                                                                            0)];
            
            UIImageView *commenterProfilePic = [[UIImageView alloc] initWithImage:comment.user.profile];
            commenterProfilePic.frame = CGRectMake(STORY_MARGIN, STORY_MARGIN, 36, 36);
            
            UILabel *commenterName = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 0, 0)];
            commenterName.text = comment.user.name;
            [commenterName sizeToFit];
            [commenterName setFont:[UIFont fontWithName:@"Bariol-Bold" size:16]];
            
            UILabel *commentTime = [[UILabel alloc] initWithFrame:CGRectMake(55 + commenterName.frame.size.width, 50, 0, 0)];
            
        }
    }
    
    StoryView *storyView = [[StoryView alloc] initWithFrame:storyInfo.frame StoryInfo:storyInfo StoryView:storyTextView Comments:nil];

    self.view = storyView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithStory:(NSString*)story
             Comments:(NSArray*)comments
            LikeCount:(NSInteger)count
                 User:(User*)user
{
    if (self = [super init]) {
        self.storyModel = [[StoryModel alloc] initWithUser:user
                                                     Story:story
                                                 LikeCount:count
                                                  Comments:comments];

    }
    
    return self;
}

@end