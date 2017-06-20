//
//  CategoryListViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "CategoryListViewController.h"
#import "PlayListTableViewController.h"
#import "VideoListTableViewController.h"
#import "CategoryManager.h"
#import "Constants.h"

#import "YTItem.h"
#import "YTTableViewCell.h"
#import "YouTubeAPIHelper.h"


@interface CategoryListViewController ()

@property (nonatomic, strong) NSMutableArray *categotyArray;
@property (strong, nonatomic) YouTubeAPIHelper *youtubeAPI;

@end

@implementation CategoryListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.categotyArray = [[NSMutableArray alloc] initWithArray:[CATEGORY_MANAGER getLeagueArray]];
    
    [self.menuTableview setScrollsToTop:YES];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect rect = [self.view frame];
    rect.size.height -= HEIGHT_BANNER;
    
    [self.view setFrame:rect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categotyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%ld_%ld",(long) indexPath.section, (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        
//        [cell.textLabel setText:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
//        [cell.textLabel setTextColor:[UIColor whiteColor]];
        
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setText:[self.categotyArray objectAtIndex:indexPath.row][@"year"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self callYoutubeSearchApiWithSearchString:[self.categotyArray objectAtIndex:indexPath.row][@"year"] indexPath:indexPath];
//    Playlist* playlist = [playListArray objectAtIndex:indexPath.row];
//
//    VideoListTableViewController *vList = [[VideoListTableViewController alloc] init];
//    [vList setPlayListID:playlist.playListID];
//    [self.navigationController pushViewController:vList animated:YES];

    
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PlayListTableViewController *collectionView =[storyboard instantiateViewControllerWithIdentifier:@"PlayListTableViewController"];
//    [self.navigationController pushViewController:collectionView animated:TRUE];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.f;
}

- (void)callYoutubeSearchApiWithSearchString:(NSString*)qString indexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:qString forKey:@"q"];
    
    self.youtubeAPI = [[YouTubeAPIHelper alloc] init];
    
    [self.youtubeAPI settingAccessToken:@""];
    [self.youtubeAPI.paramaters addEntriesFromDictionary:param];
    
    [self.youtubeAPI getListPlaylistInChannel:@"UCX1DpoQkBN4rv5ZfPivA_Wg" completion:^(BOOL success, NSError *error) {
        if (success) {

            if([self.youtubeAPI.searchItem.items count]==0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"검색조건에 맞는 동영상이 존재하지 않습니다." delegate:self
                                                      cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            
            YTItem *tempYTItem = (YTItem *)[self.youtubeAPI.searchItem.items objectAtIndex:indexPath.row];

            NSString *playListID = [tempYTItem id][@"playlistId"];
            if([playListID length]>0)
            {
                VideoListTableViewController *vList = [[VideoListTableViewController alloc] init];
                [vList setPlayListID:playListID];
                [self.navigationController pushViewController:vList animated:YES];
            }
        }
    }];
}

@end
