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
#import "VideoListCollectionViewController.h"
#import "Video.h"

@interface PlayListTableViewController (){
    NSMutableArray *playListArray;
}

@end

@implementation PlayListTableViewController
-(void)viewWillAppear:(BOOL)animated{
//    NSString* channelID=@"UCBkNpeyvBO2TdPGVC_PsPUA";
//    NSString* YOUTUBEAPIKEY=@"AIzaSyDzrIplc-gRzsviQyn8ndTv7Usaa4SvBdU";
//    items=[[NSArray alloc] init];
//    // Do any additional setup after loading the view, typically from a nib.
//    NSDictionary* userData=@{
//                             
//                             };
//    [HTTPRequestHandler HTTPGetMethod:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=%@&key=%@",channelID,YOUTUBEAPIKEY] andParameter:userData andSelector:@selector(getData:) andTarget:self];
//    [SVProgressHUD show];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    playListArray=[[NSMutableArray alloc] init];
    [self serviceCallForPlayList];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return playListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayListTableViewCell *cell = (PlayListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    // Configure the cell...
    
    Playlist *playlist=[[Playlist alloc] init];
    NSURL* url=[NSURL URLWithString:playlist.imgURL];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    playlist=[playListArray objectAtIndex:indexPath.row];
    cell.playListName.text=playlist.playlistName;
    cell.playListImg.image=image;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Playlist* playlist=[[Playlist alloc] init];
    playlist=[playListArray objectAtIndex:indexPath.row];
    NSLog(@"the items %@",playlist.playListID);
    [self serviceCallForVideos:playlist.playListID];
    
    
    
    
}

#pragma mark - API Method
-(void)serviceCallForPlayList{
    NSString* channelID=yCHANNELID;
    NSDictionary* userData=@{
                             
                             };
    [HTTPRequestHandler HTTPGetMethod:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=%@&key=%@",channelID,yYOUTUBEAPI] andParameter:userData andSelector:@selector(getData:) andTarget:self];
//    [SVProgressHUD show];
}
-(void)serviceCallForVideos:(NSString*)playlistID{
    NSDictionary* userData=@{
                             
                             };
    [HTTPRequestHandler HTTPGetMethod:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=%@&key=%@",playlistID,yYOUTUBEAPI] andParameter:userData andSelector:@selector(getVideoData:) andTarget:self];
//    [SVProgressHUD show];
}
-(void)getData:(id)response{
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
//    [SVProgressHUD dismiss];
    
}

-(void)getVideoData:(id)response{
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
//    [SVProgressHUD dismiss];
    VideoListCollectionViewController *collectionView =[self.storyboard instantiateViewControllerWithIdentifier:@"VideoListVC"];
    collectionView.videoArray=allVideos;
    [self.navigationController pushViewController:collectionView animated:TRUE];
    
}
-(void)requestError:(id)error{
    NSLog(@"the error is %@",error);
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
