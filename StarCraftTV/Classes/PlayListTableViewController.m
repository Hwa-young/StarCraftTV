//
//  PlayListTableViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "PlayListTableViewController.h"
#import "HTTPRequestHandler.h"
#import "PlayListTableViewCell.h"
#import "Constants.h"
#import "Playlist.h"
#import "VideoListTableViewController.h"
#import "Video.h"

#import <SDWebImage/UIImageView+WebCache.h>


@implementation PlayListTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayListTableViewCell" bundle:nil] forCellReuseIdentifier:@"PlayListTableViewCell"];
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    if(playListArray != (id)[NSNull null])
        playListArray = [[NSMutableArray alloc] init];
    
    [self serviceCallForPlayList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete implementation, return the number of rows
    return playListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayListTableViewCell *cell = (PlayListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PlayListTableViewCell"];
    
    Playlist *playlist = [playListArray objectAtIndex:indexPath.row];
    [cell.playListImg sd_setImageWithURL:[NSURL URLWithString:playlist.imgURL] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(error)
        {
        }
    }];

    cell.playListName.text = playlist.playlistName;
    cell.playListName.textColor = [UIColor redColor];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Playlist* playlist = [playListArray objectAtIndex:indexPath.row];
    
    VideoListTableViewController *vList = [[VideoListTableViewController alloc] init];
    [vList setPlayListID:playlist.playListID];
    [self.navigationController pushViewController:vList animated:YES];

    
//    Playlist* playlist = [playListArray objectAtIndex:indexPath.row];
//    [self serviceCallForVideos:playlist.playListID];
}

#pragma mark - API Method

- (void)serviceCallForPlayList
{
    NSString* channelID = yCHANNELID;
    NSDictionary* userData = @{};
    [HTTPRequestHandler HTTPGetMethod:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=snippet&maxResults=50&channelId=%@&key=%@",channelID,yYOUTUBEAPI] andParameter:userData andSelector:@selector(getData:) andTarget:self];
}

- (void)serviceCallForVideos:(NSString*)playlistID
{
    NSDictionary* userData = @{};
    [HTTPRequestHandler HTTPGetMethod:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlistItems?part=id,snippet,contentDetails,status&maxResults=50&playlistId=%@&key=%@",playlistID,yYOUTUBEAPI] andParameter:userData andSelector:@selector(getVideoData:) andTarget:self];
    
    
}

- (void)getData:(id)response
{
   // NSLog(@"the response is %@",response);
     NSArray* items=[response valueForKey:yITEMS];
    
    for (NSDictionary* dic in items) {
        Playlist* playlist=[[Playlist alloc] init];
        playlist.playlistName=[[[dic valueForKey:ySNIPPETS] valueForKey:yLOCALIZED] valueForKey:yTITLE];
        playlist.imgURL=[[[[dic valueForKey:ySNIPPETS] valueForKey:yTHUMBNAILS] valueForKey:yDEFAULTS] valueForKey:yURL];
        playlist.playListID=[dic valueForKey:yID];
        [playListArray addObject:playlist];
    }
    for (Playlist* list in playListArray) {
        NSLog(@"the data is %@",list.showPlaylistData);
    }
    
    
    NSLog(@"the items are %@",[items objectAtIndex:0]);
    [self.tableView reloadData];
}

- (void)getVideoData:(id)response
{
    NSLog(@"the videoData is %@",response);
    NSArray* videos=[response valueForKey:yITEMS];
    NSMutableArray* allVideos=[[NSMutableArray alloc] init];
    
    for (NSDictionary* dic in videos) {
        Video* video=[[Video alloc] init];
        video.videoName=[[dic valueForKey:ySNIPPETS] valueForKey:yTITLE];
        video.videoImg=[[[[dic valueForKey:ySNIPPETS] valueForKey:yTHUMBNAILS] valueForKey:yDEFAULTS] valueForKey:yURL];
        video.videoID=[[[dic valueForKey:ySNIPPETS] valueForKey:yRESOURCEID] valueForKey:yVIDEOID];
        [allVideos addObject:video];
    }
    for (Video* vid in allVideos) {
        NSLog(@"the video specific data is %@",vid.showAllVideoData);
    }
    
    NSLog(@"%@", allVideos);
    
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    VideoListTableViewController *collectionView =[storyboard instantiateViewControllerWithIdentifier:@"VideoListTableViewController"];
//    collectionView.videoArray=allVideos;
//    [self.navigationController pushViewController:collectionView animated:TRUE];
}

- (void)requestError:(id)error
{
    NSLog(@"the error is %@",error);
}

- (void)scrollViewDidScroll: (UIScrollView*)scrollView
{
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset == 0)
    {
        // then we are at the top
    }
    else if (scrollOffset + scrollViewHeight > scrollContentSizeHeight-1000 )
    {
    }
}

@end
