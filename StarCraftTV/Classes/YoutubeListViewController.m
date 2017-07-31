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

#import "Constants.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>

#import "GAManager.h"

@interface YoutubeListViewController ()

@property (strong, atomic) YTSearchItem *searchItem;
@property (strong, atomic) NSMutableArray *tableItem;
@property (strong, atomic) NSMutableDictionary *parameters;
@property (copy, nonatomic) NSString *keySearchOld;
@property (nonatomic, assign)BOOL isLoading;

@property (strong, nonatomic) YouTubeAPIHelper *youtubeAPI;

@end

@implementation YoutubeListViewController

- (void)viewDidLoad
{
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
    self.youtubeAPI = [[YouTubeAPIHelper alloc] init];
    
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

    [self.youtubeAPI getListVideoByKeySearch:@"starcrafttvapp" completion:^(BOOL success, NSError *error) {
        
        if([self.youtubeAPI.searchItem.items count]>0)
        {
            [self.tableItem addObjectsFromArray:self.youtubeAPI.searchItem.items];
            [self.tableView reloadData];
            
            [self.NoticeLabel setHidden:YES];
        }
        else
        {
            [self.NoticeLabel setHidden:NO];
            [self.tableView setHidden:YES];
        }
        
        self.isLoading = NO;
        [SVProgressHUD dismiss];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"YTTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTItem *tempItem = self.tableItem[indexPath.row];
    [(YTTableViewCell*)cell setTabelviewCell:tempItem];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTItem *tempItem = self.tableItem[indexPath.row];

    YoutubeViewController *controller = [[YoutubeViewController alloc] initWithNibName:@"YoutubeViewController" bundle:nil title:tempItem.snippet.title];
    [controller setVideoID:tempItem.id[@"videoId"]];

    [self.navigationController pushViewController:controller animated:YES];
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

        [self.youtubeAPI getListVideoByKeySearch:@"starcrafttvapp" completion:^(BOOL success, NSError *error) {
            if([self.youtubeAPI.searchItem.items count]>0)
            {
                [self.tableItem addObjectsFromArray:self.youtubeAPI.searchItem.items];
                [self.tableView reloadData];
                
                [self.NoticeLabel setHidden:YES];
            }
            else
            {
//                [self.NoticeLabel setHidden:NO];
//                [self.tableView setHidden:YES];
            }
            self.isLoading = NO;
            [SVProgressHUD dismiss];
        }];
    }
}

@end
