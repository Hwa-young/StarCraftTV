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
#import "Video.h"
#import "YoutubeViewController.h"


@interface VideoListTableViewController ()

@end

@implementation VideoListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoListTableViewCell" bundle:nil] forCellReuseIdentifier:@"VideoListTableViewCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

    return _videoArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VideoListTableViewCell *cell = (VideoListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"VideoListTableViewCell"];

    Video* video=[[Video alloc] init];
    video=[_videoArray objectAtIndex:indexPath.row];
    NSURL* url=[NSURL URLWithString:video.videoImg];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    cell.videoName.text=video.videoName;
    cell.videoImage.image=image;


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Video* video=[[Video alloc] init];
    video=[_videoArray objectAtIndex:indexPath.row];
    
    YoutubeViewController *vc= [[YoutubeViewController alloc] initWithNibName:@"YoutubeViewController" bundle:nil];
    [vc setVideoID:video.videoID];
    [vc setVideoThumnailImage:video.videoImg];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
