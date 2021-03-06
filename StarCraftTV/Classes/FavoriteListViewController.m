//
//  YoutubeViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "FavoriteListViewController.h"
#import "YoutubeViewController.h"

#import "YTTableViewCell.h"
#import "YTSearchItem.h"
#import "YTItem.h"
#import "YouTubeAPIHelper.h"

#import "Constants.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>

#import "GAManager.h"

@interface FavoriteListViewController ()

@property (strong, atomic) YTSearchItem *searchItem;
@property (strong, atomic) NSMutableArray *tableItem;
@property (strong, atomic) NSMutableDictionary *parameters;
@property (copy, nonatomic) NSString *keySearchOld;
@property (nonatomic, assign)BOOL isLoading;

@end

@implementation FavoriteListViewController

- (void)viewDidLoad
{
    [self setTitle:NSLocalizedString(@"FAVORITES", @"FAVORITES")];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-60, -60) forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];

    
    [super viewDidLoad];
        
    [GAManager trackWithView:NSStringFromClass(self.class)];
    
    self.isLoading = NO;

    self.shyNavBarManager.scrollView = self.tableView;
    self.shyNavBarManager.scrollView.scrollsToTop = NO;

    [self.tableView registerNib:[UINib nibWithNibName:@"YTTableViewCell" bundle:nil] forCellReuseIdentifier:@"YTTableViewCell"];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadData:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];

    self.tableView.alwaysBounceVertical = YES;
    
    self.tableItem = [NSMutableArray array];
    
//    UISearchBar *searchBar = [UISearchBar new];
//    searchBar.placeholder = @"Enter text search";
//    searchBar.delegate = self;
//    self.navigationItem.titleView = searchBar;

    [self initDataForTable];
}

- (void)reloadData:(UIRefreshControl *)refreshControl
{
    [refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:1.0f];
//    [refreshControl endRefreshing];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect rect = [self.view frame];
    rect.size.height -= HEIGHT_BANNER;

    [self.view setFrame:rect];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tableView.scrollsToTop = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initDataForTable
{
    [SVProgressHUD show];
    self.isLoading = YES;
    
    [self.tableItem removeAllObjects];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"MYVIDEOS"]];
    if([array count]>0)
    {
        [self.tableItem addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.NoticeLabel setHidden:YES];
    }
    else
    {
        [self.NoticeLabel setHidden:NO];
        [self.tableView setHidden:YES];
    }
    [SVProgressHUD dismiss];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"YTTableViewCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    YouTubeAPIHelper *infoAPI = [[YouTubeAPIHelper alloc] init];
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[self.tableItem objectAtIndex:indexPath.row] forKey:@"videoId"];
    
    [infoAPI.paramaters addEntriesFromDictionary:param];
    [infoAPI getVideoInfo:[self.tableItem objectAtIndex:indexPath.row] completion:^(BOOL success, NSError *error) {
        if (success) {
            
            [cell.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:[(YTItem*)[infoAPI.videoItem.items objectAtIndex:0] snippet].thumbnails[@"default"][@"url"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];

            
            [cell.titleLabel setText:[(YTItem*)[infoAPI.videoItem.items objectAtIndex:0] snippet].title];
            
            if([[ UIScreen mainScreen ] bounds ].size.height == 568)
            {
                [cell.dateLabel setText:[NSString stringWithFormat:@"조회수 : %@ / %@",
                                         [infoAPI.statisticsItem objectForKey:@"viewCount"],
                                         [self parseDuration:[infoAPI.videoInfoItem objectForKey:@"duration"]]]];
            }
            else
            {
                [cell.dateLabel setText:[NSString stringWithFormat:@"조회수 : %@ / 재생시간 : %@",
                                         [infoAPI.statisticsItem objectForKey:@"viewCount"],
                                         [self parseDuration:[infoAPI.videoInfoItem objectForKey:@"duration"]]]];
            }
        }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tempItem = self.tableItem[indexPath.row];

    YTTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    YoutubeViewController *controller = [[YoutubeViewController alloc] initWithNibName:@"YoutubeViewController" bundle:nil title:
                                         cell.titleLabel.text];
    [controller setVideoID:tempItem];

    [self.navigationController pushViewController:controller animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self removeVideoID:indexPath];
        
        [self.tableItem removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        
        if([self.tableItem count] == 0)
        {
            [self.NoticeLabel setHidden:NO];
            [self.tableView setHidden:YES];
        }
    }
}

- (NSString *)parseDuration:(NSString *)duration
{
    if(!duration) return @"";
    
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
    if(hours==0.f)
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    else
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

- (void)removeVideoID:(NSIndexPath *)indexPath
{
    if(!self.tableItem) return;

    NSMutableArray *array;
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"MYVIDEOS"])
        array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"MYVIDEOS"]];
    else
        array = [NSMutableArray array];
    
    NSString *videoID = [self.tableItem objectAtIndex:indexPath.row];
    
    if ([array containsObject:videoID])
    {
        [array removeObjectAtIndex:indexPath.row];
        
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"MYVIDEOS"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


@end
