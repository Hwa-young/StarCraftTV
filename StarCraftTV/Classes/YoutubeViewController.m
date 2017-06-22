//
//  YoutubeViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "YoutubeViewController.h"
#import "MPMoviePlayerController+BackgroundPlayback.h"

#import "YTItem.h"
#import "YTTableViewCell.h"
#import "YouTubeAPIHelper.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import <SVProgressHUD/SVProgressHUD.h>


@interface YoutubeViewController ()

@property (nonatomic, strong) XCDYouTubeVideoPlayerViewController *videoPlayerViewController;
@property (strong, nonatomic) YouTubeAPIHelper *youtubeAPI;

@end

@implementation YoutubeViewController

- (void)setNavigationTitle:(NSString*)titleString
{
    [self.navigationItem setTitle:titleString];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:17]};
    [[self.navigationController navigationBar] setTitleTextAttributes:attributes];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.listTableView registerNib:[UINib nibWithNibName:@"YTTableViewCell" bundle:nil] forCellReuseIdentifier:@"YTTableViewCell"];
    
    [self initDataForTable];

    
    [SVProgressHUD show];

    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(moviePlayerLoadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(moviePlayerNowPlayingMovieDidChange:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];

    NSString *videoId =_videoID;
    NSString *videoIdentifier = videoId;
    self.videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:videoIdentifier];    
    self.videoPlayerViewController.moviePlayer.backgroundPlaybackEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlayVideoInBackground"];
    [self.videoPlayerViewController presentInView:self.playerView];

    [self.videoPlayerViewController.moviePlayer prepareToPlay];
    self.videoPlayerViewController.moviePlayer.shouldAutoplay = YES;
}

- (void)initDataForTable
{
    [self.tableItem removeAllObjects];
//
    self.youtubeAPI = [[YouTubeAPIHelper alloc] init];
    self.tableItem = [NSMutableArray array];

    NSMutableDictionary *param = [NSMutableDictionary new];
    // Test Code
    [param setObject:@"PLIyPfbjeOk-NBE3EtDhm5pPVG4njU0BCK" forKey:@"playlistId"];

    [self.youtubeAPI settingAccessToken:@""];
    [self.youtubeAPI.paramaters addEntriesFromDictionary:param];
//
    [self.youtubeAPI getListVideoByPlayListWithType:PLAYLISTITEM completion:^(BOOL success, NSError *error) {
        if (success) {
            [self.tableItem addObjectsFromArray:self.youtubeAPI.searchItem.items];
            [self.listTableView reloadData];
        }
    }];
}

- (void)moviePlayerLoadStateDidChange:(NSNotification *)notification
{
    MPMoviePlayerController *moviePlayerController = notification.object;
    
    NSMutableString *loadState = [NSMutableString new];
    MPMovieLoadState state = moviePlayerController.loadState;
    if (state & MPMovieLoadStatePlayable)
        [loadState appendString:@" | Playable"];
    if (state & MPMovieLoadStatePlaythroughOK)
        [loadState appendString:@" | Playthrough OK"];
    if (state & MPMovieLoadStateStalled)
        [loadState appendString:@" | Stalled"];
    
    NSLog(@"Load State: %@", loadState.length > 0 ? [loadState substringFromIndex:3] : @"N/A");
}

- (void)moviePlayerNowPlayingMovieDidChange:(NSNotification *)notification
{
    MPMoviePlayerController *moviePlayerController = notification.object;
    NSLog(@"Now Playing %@", moviePlayerController.contentURL);
    
    [SVProgressHUD dismiss];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

//     Beware, viewWillDisappear: is called when the player view enters full screen on iOS 6+
    if ([self isMovingFromParentViewController])
        [self.videoPlayerViewController.moviePlayer stop];
    
    [SVProgressHUD dismiss];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTTableViewCell *cell = [self.listTableView dequeueReusableCellWithIdentifier:@"YTTableViewCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    YTItem *tempItem = self.tableItem[indexPath.row];
    
    cell.thumbnailImage.image = nil;
    [cell.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:tempItem.snippet.thumbnails[@"default"][@"url"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(error)
        {
        }
    }];
    
    cell.titleLabel.text = tempItem.snippet.title;
    cell.dateLabel.text = tempItem.snippet.publishedAt;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTItem *tempItem = self.tableItem[indexPath.row];
    
    YoutubeViewController *controller = [[YoutubeViewController alloc] initWithNibName:@"YoutubeViewController" bundle:nil];
    [controller setVideoID:tempItem.id[@"videoId"]];
    
    [self.navigationController pushViewController:controller animated:YES];
    
//    Video* video=[[Video alloc] init];
//    video=[_videoArray objectAtIndex:indexPath.row];
//
//    YoutubeViewController *vc= [[YoutubeViewController alloc] initWithNibName:@"YoutubeViewController" bundle:nil];
//    [vc setVideoID:video.videoID];
//    [vc setVideoThumnailImage:video.videoImg];
//
//    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


@end
