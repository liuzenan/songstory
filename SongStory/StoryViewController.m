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

}

- (id)initWithName:(NSString*)username LikeCount:(NSInteger)count Story:(NSString*)story Comments:(NSArray*)comments
{
    if (self = [super init]) {
        NSMutableArray *commentsList = [NSMutableArray array];
        
        for (int i = 0; i < 10; i++) {
            Comment *comment = [[Comment alloc] initWithUser:[[User alloc] initWithName:username]
                                                     Comment:@"This is a great story, thanks for sharing!"
                                                 CurrentTime:[[NSDate alloc] initWithTimeIntervalSinceNow:0]];
            comment.user.profile = [UIImage imageNamed:@"user1.jpg"];
            [commentsList addObject:comment];
        }
        
        self.storyModel = [[StoryModel alloc] initWithUser:[[User alloc] initWithName:username]
                                                     Story:story
                                                 LikeCount:count
                                                  Comments:commentsList
                                                CreateTime:[[NSDate alloc] initWithTimeIntervalSinceNow:0]];
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
    UILabel *profileName = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 0, 0)];
    profileName.text = self.storyModel.user.name;
    [profileName setFont:[UIFont fontWithName:@"Bariol-Bold" size:18]];
    [profileName sizeToFit];
    profileName.backgroundColor = [UIColor clearColor];
    
    // create time
    UILabel *storyCreateTime = [[UILabel alloc] initWithFrame:CGRectMake(50, 24, 0, 0)];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    storyCreateTime.text = [dateFormatter stringFromDate:self.storyModel.createTime];
    [storyCreateTime setFont:[UIFont fontWithName:@"Bariol" size:12]];
    [storyCreateTime sizeToFit];
    storyCreateTime.backgroundColor = [UIColor clearColor];
    
    // like count
    UILabel *likeCount = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width - STORY_MARGIN - 50, 10, 0, 0)];
    likeCount.text = [NSString stringWithFormat:@"%d", self.storyModel.likeCount];
    [likeCount setFont:[UIFont fontWithName:@"Bariol" size:18]];
    [likeCount sizeToFit];
    likeCount.backgroundColor = [UIColor clearColor];
    
    UIImageView *heart = [[UIImageView alloc] initWithImage:[UIImage imageNamed:HEART_IMAGE]];
    heart.frame = CGRectMake(screenRect.size.width - STORY_MARGIN - 35, 5, 25, 25);
    heart.backgroundColor = [UIColor clearColor];
    
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
    storyTextView.backgroundColor = [UIColor clearColor];
    
    UIView *commentsView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                    storyTextView.frame.origin.y + storyTextView.frame.size.height + 10,
                                                                    storyWidth,
                                                                    0)];
    if (self.storyModel.comments) {
        CGFloat topY = 0;
        for (int i = 0; i < [self.storyModel.comments count]; i++) {
            
            Comment *comment = (Comment*)[self.storyModel.comments objectAtIndex:i];
            UIView *commentItem  = [[UIView alloc] initWithFrame:CGRectMake(0, topY, storyWidth, 0)];
            
            UIImageView *commenterProfilePic = [[UIImageView alloc] initWithImage:comment.user.profile];
            commenterProfilePic.frame = CGRectMake(STORY_MARGIN, STORY_MARGIN, 36, 36);
            profilePicLayer = [commenterProfilePic layer];
            [profilePicLayer setMasksToBounds:YES];
            [profilePicLayer setCornerRadius:5.0];
            
            UILabel *commenterName = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 0, 0)];
            commenterName.text = comment.user.name;
            [commenterName setFont:[UIFont fontWithName:@"Bariol-Bold" size:14]];
            [commenterName sizeToFit];
            commenterName.backgroundColor = [UIColor clearColor];
            
            UILabel *commentText = [[UILabel alloc] initWithFrame:CGRectMake(50,
                                                                             5 + commenterName.frame.size.height,
                                                                             storyWidth - 55,
                                                                             0)];
            commentText.text = comment.comment;
            [commentText setFont:[UIFont fontWithName:@"Bariol" size:14]];
            font = commentText.font;
            constraintSize = CGSizeMake(commentText.frame.size.width, MAXFLOAT);
            commentText.adjustsFontSizeToFitWidth = NO;
            commentText.numberOfLines = 0;
            CGSize commentTextLabelSize = [commentText.text sizeWithFont:font
                                                  constrainedToSize:constraintSize
                                                      lineBreakMode:NSLineBreakByWordWrapping];
            commentText.frame = CGRectMake(commentText.frame.origin.x,
                                           commentText.frame.origin.y,
                                           commentText.frame.size.width,
                                           commentTextLabelSize.height);
            commentText.backgroundColor = [UIColor clearColor];
            
            UILabel *commentTime = [[UILabel alloc] initWithFrame:CGRectMake(50,
                                                                             5 + commenterName.frame.size.height + commentTextLabelSize.height,
                                                                             0,
                                                                             0)];
            commentTime.text = [dateFormatter stringFromDate:comment.commentTime];
            [commentTime setFont:[UIFont fontWithName:@"Bariol" size:12]];
            [commentTime sizeToFit];
            commentTime.backgroundColor = [UIColor clearColor];
            
            [commentItem addSubview:commenterProfilePic];
            [commentItem addSubview:commenterName];
            [commentItem addSubview:commentText];
            [commentItem addSubview:commentTime];
            commentItem.frame = CGRectMake(0,
                                           commentItem.frame.origin.y,
                                           storyWidth,
                                           5 + commentTime.frame.origin.y + commentTime.frame.size.height);
            // Add a topBorder.
            CALayer *topBorder = [CALayer layer];
            
            topBorder.frame = CGRectMake(0.0f, topY, commentItem.frame.size.width, 1.0f);
            
            topBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                          alpha:1.0f].CGColor;
            
            [commentsView.layer addSublayer:topBorder];
            [commentsView addSubview:commentItem];
            topY += commentItem.frame.size.height;
        }
        CGRect frame = commentsView.frame;
        frame.size.height = topY;
        commentsView.frame = frame;
    }
    
    StoryView *storyView = [[StoryView alloc] initWithFrame:storyInfo.frame StoryInfo:storyInfo StoryView:storyTextView Comments:commentsView];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.contentSize = CGSizeMake(screenRect.size.width, storyView.frame.size.height + storyView.frame.origin.y + 49);
    self.view = scrollView;
    [self.view addSubview:storyView];
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
         CreateTime:(NSDate*)date
{
    if (self = [super init]) {
        self.storyModel = [[StoryModel alloc] initWithUser:user
                                                     Story:story
                                                 LikeCount:count
                                                  Comments:comments
                                                CreateTime:date];

    }
    
    return self;
}

@end