//
//  YoutubeViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "YoutubeListViewController.h"
#import "YoutubeViewController.h"

#import "YTTableViewCell.h"
#import "YTSearchItem.h"
#import "YTItem.h"
#import "YouTubeAPIHelper.h"
#import "ActivitiItem.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>

@interface YoutubeListViewController ()

@property (strong, atomic) YTSearchItem *searchItem;
@property (strong, atomic) NSMutableArray *tableItem;
@property (strong, atomic) NSMutableDictionary *parameters;
@property (copy, nonatomic) NSString *keySearchOld;

@property (strong, nonatomic) YouTubeAPIHelper *youtubeAPI;

@end

@implementation YoutubeListViewController

dispatch_queue_t queueImage;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.shyNavBarManager.scrollView = self.tableView;
    self.shyNavBarManager.scrollView.scrollsToTop = YES;

    [self.tableView registerNib:[UINib nibWithNibName:@"YTTableViewCell" bundle:nil] forCellReuseIdentifier:@"YTTableViewCell"];

    self.tableView.alwaysBounceVertical = YES;
//    self.tableView.backgroundColor = [UIColor redColor];
    
    queueImage = dispatch_queue_create("thumbnaisVideo", NULL);
    self.tableItem = [NSMutableArray array];
    self.youtubeAPI = [[YouTubeAPIHelper alloc] init];
    
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.placeholder = @"Enter text search";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;

    [self initDataForTable];
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
    
    [self.tableItem removeAllObjects];

    [self.youtubeAPI settingAccessToken:@""];
    [self.youtubeAPI getListVideoByKeySearch:@"" completion:^(BOOL success, NSError *error) {
        [self.tableItem addObjectsFromArray:self.youtubeAPI.searchItem.items];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
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

    YoutubeViewController *controller = [[YoutubeViewController alloc] initWithNibName:@"YoutubeViewController" bundle:nil];
    [controller setVideoID:tempItem.id[@"videoId"]];

    [self.navigationController pushViewController:controller animated:YES];
}

@end
