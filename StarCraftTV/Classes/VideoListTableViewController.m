//
//  VideoListTableViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 6. 14..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "VideoListTableViewController.h"
#import "Constants.h"
#import "YoutubeViewController.h"

#import "YTItem.h"
#import "YTTableViewCell.h"
#import "YouTubeAPIHelper.h"

#import "KPDropMenu.h"
#import "GAManager.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface VideoListTableViewController () <KPDropMenuDelegate>

@property (strong, nonatomic) YouTubeAPIHelper  *youtubeAPI;
@property (strong, nonatomic) KPDropMenu        *dropNew;

@property (nonatomic, assign)BOOL               isLoading;
@end

@implementation VideoListTableViewController

- (instancetype)initWithFilterHeader:(BOOL)flag
{
    self = [super init];
    if(self)
    {
        _needFilterFlag = flag;
        self.isLoading = NO;
        
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-60, -60) forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [GAManager trackWithView:NSStringFromClass(self.class)];
//    [self.navigationItem setTitle:[NSString stringWithFormat:@"%@", _queryString]];
    
    if([_queryString length]==3 && _queryString!=nil)
        [self.navigationItem setTitle:[NSString stringWithFormat:@"%@ 선수 영상 모음", _queryString]];
    else
        [self.navigationItem setTitle:[NSString stringWithFormat:@"%@ 스타리그", _queryString]];

    [self.tableView registerNib:[UINib nibWithNibName:@"YTTableViewCell" bundle:nil] forCellReuseIdentifier:@"YTTableViewCell"];
    
    [self initDataForTable];
}

- (void)initDataForTable
{
    [SVProgressHUD show];
    self.isLoading = YES;
    
    [self.tableItem removeAllObjects];
    
    self.youtubeAPI = [[YouTubeAPIHelper alloc] init];
    self.tableItem = [NSMutableArray array];
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:_queryString forKey:@"q"];
    [self.youtubeAPI.paramaters addEntriesFromDictionary:param];
    [self.youtubeAPI getListPlaylistItemsInChannel:self.channelID atQueryString:_queryString completion:^(BOOL success, NSError *error) {
        if (success)
        {
            [self.tableItem addObjectsFromArray:self.youtubeAPI.searchItem.items];
            [self.tableView reloadData];
        }
        [SVProgressHUD dismiss];
        self.isLoading = NO;
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(_needFilterFlag==NO) return nil;
    if(!self.dropNew)
    {
        self.dropNew = [[KPDropMenu alloc] initWithFrame:CGRectMake(0, 0, 375, 50)];
        self.dropNew.delegate = self;
        self.dropNew.items = @[@"결승", @"4강", @"8강", @"16강", @"24강"];
        self.dropNew.backgroundColor = [UIColor whiteColor];
        self.dropNew.title = @"토너먼트";
        self.dropNew.titleColor = [UIColor redColor];
        self.dropNew.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        self.dropNew.titleTextAlignment = NSTextAlignmentCenter;
        self.dropNew.DirectionDown = YES;
        [self.view addSubview:self.dropNew];
    }
    return self.dropNew;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(_needFilterFlag==YES)
        return 50.f;
    else
        return 0.f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

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
    YTTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"YTTableViewCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    YTItem *tempItem = self.tableItem[indexPath.row];
    
    cell.thumbnailImage.image = nil;
    [cell.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:tempItem.snippet.thumbnails[@"default"][@"url"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(error)
        {
        }
    }];

    NSString * newReplacedString = [tempItem.snippet.title stringByReplacingOccurrencesOfString:@"경기 " withString:@"경기\n"];
    cell.titleLabel.text = newReplacedString;
    cell.dateLabel.text = tempItem.snippet.publishedAt;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTItem *tempItem = self.tableItem[indexPath.row];
    
    YoutubeViewController *controller = [[YoutubeViewController alloc] initWithNibName:@"YoutubeViewController" bundle:nil title:tempItem.snippet.title];
    [controller setVideoID:tempItem.id[@"videoId"]];
    if(self.playListID)
        [controller setPlaylistId:self.playListID];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIndex
{
    if(self.isLoading == YES) return;
    
    [SVProgressHUD show];
    self.isLoading = YES;

    [self.tableItem removeAllObjects];
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[NSString stringWithFormat:@"%@ %@", _queryString, [dropMenu.items objectAtIndex:atIndex]] forKey:@"q"];
    
    [self.youtubeAPI.paramaters addEntriesFromDictionary:param];
    
    [self.youtubeAPI getListPlaylistItemsInChannel:self.channelID atQueryString:[NSString stringWithFormat:@"%@ %@", _queryString, [dropMenu.items objectAtIndex:atIndex]] completion:^(BOOL success, NSError *error) {
        if (success)
        {
            [self.tableItem removeAllObjects];
            
            [self.tableItem addObjectsFromArray:self.youtubeAPI.searchItem.items];
            [self.tableView reloadData];
        }
        [SVProgressHUD dismiss];
        self.isLoading = NO;
    }];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

-(void)scrollViewDidScroll: (UIScrollView*)scrollView
{
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset == 0)
    {
        // then we are at the top
    }
    else if (scrollOffset + scrollViewHeight > scrollContentSizeHeight-100 && scrollOffset > 0  && scrollOffset > 0)
    {
        if(self.isLoading == YES) return;
        if(self.youtubeAPI.searchItem.nextPageToken == nil || [self.youtubeAPI.searchItem.nextPageToken length]==0) return;
        
        [SVProgressHUD show];
        self.isLoading = YES;
        
        NSMutableDictionary *param = [NSMutableDictionary new];
        [param setObject:self.youtubeAPI.searchItem.nextPageToken forKey:@"pageToken"];
        [self.youtubeAPI.paramaters addEntriesFromDictionary:param];
        
        [self.youtubeAPI getListPlaylistItemsInChannel:self.channelID atQueryString:_queryString completion:^(BOOL success, NSError *error) {
            if (success)
            {
                [self.tableItem addObjectsFromArray:self.youtubeAPI.searchItem.items];
                [self.tableView reloadData];
            }
            [SVProgressHUD dismiss];
            self.isLoading = NO;
        }];
    }
}


@end
