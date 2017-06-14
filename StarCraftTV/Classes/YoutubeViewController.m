//
//  YoutubeViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "YoutubeViewController.h"
#import "MPMoviePlayerController+BackgroundPlayback.h"
#import <XCDYouTubeKit/XCDYouTubeKit.h>

@interface YoutubeViewController ()
@property (nonatomic, strong) XCDYouTubeVideoPlayerViewController *videoPlayerViewController;
@end

@implementation YoutubeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *videoId =_videoID;
    NSString *videoIdentifier = videoId;
    self.videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:videoIdentifier];
    self.videoPlayerViewController.moviePlayer.backgroundPlaybackEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlayVideoInBackground"];
    [self.videoPlayerViewController presentInView:self.playerView];

    [self.videoPlayerViewController.moviePlayer prepareToPlay];
    self.videoPlayerViewController.moviePlayer.shouldAutoplay = YES;

    

//    NSString *videoId =_videoID;
//
//    NSDictionary *playerVars = @{
//                                 @"controls" : @0,
//                                 @"playsinline" : @1,
//                                 @"autohide" : @1,
//                                 @"showinfo" : @0,
//                                 @"modestbranding" : @1,
//                                 @"origin" :@"http://www.youtube.com"
//                                 };
//    self.playerView.delegate = self;
//    [self.playerView loadWithVideoId:videoId playerVars:playerVars];

}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Beware, viewWillDisappear: is called when the player view enters full screen on iOS 6+
    if ([self isMovingFromParentViewController])
        [self.videoPlayerViewController.moviePlayer stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
         {
             self.heightConstraint.constant = [[UIScreen mainScreen] applicationFrame].size.height;
             self.topHeightConstraint.constant = 0.f;
             [self.navigationController setNavigationBarHidden:YES];
             [self.navigationController setToolbarHidden:YES];
             
         }
         if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
         {
             [self.navigationController setNavigationBarHidden:NO];
             [self.navigationController setToolbarHidden:NO];
             self.heightConstraint.constant = 211.f;// 디바이스 사이즈별로 변경하자.
             self.topHeightConstraint.constant = 64.f;
         }
     }
                                 completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
                                 }];
}

@end
