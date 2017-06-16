//
//  VideoListTableViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 6. 14..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "VideoListTableViewController.h"
#import "Constants.h"
#import "HTTPRequestHandler.h"
#import "VideoListTableViewCell.h"
#import "YoutubeViewController.h"

#import "YTItem.h"
#import "YTTableViewCell.h"
#import "YouTubeAPIHelper.h"

#import <SDWebImage/UIImageView+WebCache.h>


@interface VideoListTableViewController ()

@property (strong, nonatomic) YouTubeAPIHelper *youtubeAPI;

@end

@implementation VideoListTableViewController

//dispatch_queue_t queueImage;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"YTTableViewCell" bundle:nil] forCellReuseIdentifier:@"YTTableViewCell"];
    
    [self initDataForTable];
}

- (void)initDataForTable
{
    [self.tableItem removeAllObjects];
    
    self.youtubeAPI = [[YouTubeAPIHelper alloc] init];
    self.tableItem = [NSMutableArray array];

    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:self.playListID forKey:@"playlistId"];
    
    [self.youtubeAPI settingAccessToken:@""];
    [self.youtubeAPI.paramaters addEntriesFromDictionary:param];

    [self.youtubeAPI getListVideoByPlayListWithType:PLAYLISTITEM completion:^(BOOL success, NSError *error) {
        if (success) {
            [self.tableItem addObjectsFromArray:self.youtubeAPI.searchItem.items];
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
