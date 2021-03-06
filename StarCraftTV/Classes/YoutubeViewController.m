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
#import "GAManager.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MarqueeLabel/MarqueeLabel.h>

@interface YoutubeViewController ()

@property (nonatomic, strong) XCDYouTubeVideoPlayerViewController *videoPlayerViewController;
@property (strong, nonatomic) YouTubeAPIHelper *youtubeAPI;
@property (strong, nonatomic) NSString *titleStr;

@end

@implementation YoutubeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil title:(NSString *)titleString
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationItem setTitle:titleString];
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        self.navigationItem.rightBarButtonItem = [self makeBookmarkButton];
        
        self.titleStr = titleString;
        [self.thumnailImageView setHidden:NO];
    }
    return self;
}

- (UIBarButtonItem*) makeBookmarkButton
{
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setFrame:CGRectMake(0, 0, 44, 44)];
    [btnRight setImage:[UIImage imageNamed:@"icons8-bookmark_ribbon_filled"] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(saveVideoInfo) forControlEvents:UIControlEventTouchUpInside];
    btnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    UIBarButtonItem *barBtnRight = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    [barBtnRight setTintColor:[UIColor clearColor]];
    
    return barBtnRight;
}

- (void)saveVideoInfo
{
    if(_videoID)
    {
        NSString *noticeString;
        
        NSMutableArray *array;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"MYVIDEOS"])
            array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"MYVIDEOS"]];
        else
            array = [NSMutableArray array];
        
        if (![array containsObject: _videoID]) // YES
        {
            [array addObject:_videoID];
            
            [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"MYVIDEOS"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            noticeString = [NSString stringWithFormat:@"%@ %@ %@",
                            NSLocalizedString(@"FAVORITES", @"FAVORITES"), NSLocalizedString(@"REGISTER", @"REGISTER"), NSLocalizedString(@"SUCCESS", @"SUCCESS")];
            
            [SVProgressHUD showSuccessWithStatus:noticeString];
        }
        else
        {
            noticeString = [NSString stringWithFormat:@"%@ %@ %@",
                            NSLocalizedString(@"FAVORITES", @"FAVORITES"), NSLocalizedString(@"REGISTER", @"REGISTER"), NSLocalizedString(@"FAIL", @"FAIL")];
            
            [SVProgressHUD showSuccessWithStatus:noticeString];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [GAManager trackWithView:NSStringFromClass(self.class)];
    
    [SVProgressHUD show];
    
    [self.listTableView registerNib:[UINib nibWithNibName:@"YTTableViewCell" bundle:nil] forCellReuseIdentifier:@"YTTableViewCell"];
    
    [self getVideoInformation];
    
    [self initDataForTable];

    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(moviePlayerLoadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(moviePlayerNowPlayingMovieDidChange:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
}

- (void)playYoutubeVideo
{
    if(!_videoID) return;
    
    NSString *videoId =_videoID;
    NSString *videoIdentifier = videoId;
    
    if(!self.videoPlayerViewController)
    {
        self.videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:videoIdentifier];
        self.videoPlayerViewController.moviePlayer.backgroundPlaybackEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlayVideoInBackground"];
        [self.videoPlayerViewController presentInView:self.playerView];
        
        [self.videoPlayerViewController.moviePlayer prepareToPlay];
        self.videoPlayerViewController.moviePlayer.shouldAutoplay = YES;
        
        [self.playerView bringSubviewToFront:self.thumnailImageView];
    }
    else
    {
        [self.videoPlayerViewController.moviePlayer play];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self playYoutubeVideo];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self isMovingFromParentViewController])
        [self.videoPlayerViewController.moviePlayer pause];
    
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (NSString *)parseDuration:(NSString *)duration
{
    NSInteger hours = 0;
    NSInteger minutes = 0;
    NSInteger seconds = 0;
    
    NSRange timeRange = [duration rangeOfString:@"T"];
    duration = [duration substringFromIndex:timeRange.location];
    
    while (duration.length > 1) {
        duration = [duration substringFromIndex:1];
        
        NSScanner *scanner = [NSScanner.alloc initWithString:duration];
        NSString *part = [NSString.alloc init];
        [scanner scanCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&part];
        
        NSRange partRange = [duration rangeOfString:part];
        
        duration = [duration substringFromIndex:partRange.location + partRange.length];
        
        NSString *timeUnit = [duration substringToIndex:1];
        if ([timeUnit isEqualToString:@"H"])
            hours = [part integerValue];
        else if ([timeUnit isEqualToString:@"M"])
            minutes = [part integerValue];
        else if ([timeUnit isEqualToString:@"S"])
            seconds = [part integerValue];
    }
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

- (void)getVideoInformation
{
    if(!self.videoID) return;
    
    YouTubeAPIHelper *infoAPI = [[YouTubeAPIHelper alloc] init];
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    // Test Code
    if(self.videoID)
        [param setObject:self.videoID forKey:@"videoId"];
    
    [infoAPI.paramaters addEntriesFromDictionary:param];
    //
    [infoAPI getVideoInfo:self.videoID completion:^(BOOL success, NSError *error) {
        if (success) {
            NSString *imageURL = [[[infoAPI.videoItem.items objectAtIndex:0] snippet] thumbnails][@"standard"][@"url"];
            [self.thumnailImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(error)
                {
                    [self.thumnailImageView setHidden:YES];
                }
                else
                {

                }
            }];
        }
    }];
}

- (void)initDataForTable
{
    [self.tableItem removeAllObjects];

    self.youtubeAPI = [[YouTubeAPIHelper alloc] init];
    self.tableItem = [NSMutableArray array];

    NSMutableDictionary *param = [NSMutableDictionary new];
    // Test Code
    if(self.playlistId)
        [param setObject:self.playlistId forKey:@"playlistId"];
    else
        [param setObject:@"PLIyPfbjeOk-NBE3EtDhm5pPVG4njU0BCK" forKey:@"playlistId"];

    [self.youtubeAPI.paramaters addEntriesFromDictionary:param];

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
    
    [self.thumnailImageView setHidden:YES];
    [SVProgressHUD dismiss];
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
    YTTableViewCell *cell = [self.listTableView dequeueReusableCellWithIdentifier:@"YTTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTSnippetItem *tempItem = [self.tableItem[indexPath.row] snippet];
    
    [(YTTableViewCell*)cell setTableviewWithSnippet:tempItem];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTItem *tempItem = self.tableItem[indexPath.row];
    
    YoutubeViewController *controller = [[YoutubeViewController alloc] initWithNibName:@"YoutubeViewController" bundle:nil title:tempItem.snippet.title];
    [controller setVideoID:[tempItem.snippet.resourceId objectForKey:@"videoId"]];
    
    if(self.playlistId)
        [controller setPlaylistId:self.playlistId];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
