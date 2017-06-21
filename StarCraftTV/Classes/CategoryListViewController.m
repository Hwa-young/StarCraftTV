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
@property (nonatomic, strong) NSArray *contents;

@end

@implementation CategoryListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.categotyArray = [[NSMutableArray alloc] initWithArray:[CATEGORY_MANAGER getLeagueArray]];
    
    [self.menuTableview setScrollsToTop:YES];
    
    self.menuTableview.SKSTableViewDelegate = self;
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

/*
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

        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setText:[self.categotyArray objectAtIndex:indexPath.row][@"year"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self callYoutubeSearchApiWithSearchString:[self.categotyArray objectAtIndex:indexPath.row][@"year"] indexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.f;
}
*/

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
            
            YTItem *tempYTItem = (YTItem *)[self.youtubeAPI.searchItem.items objectAtIndex:0];

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

- (NSArray *)contents
{
    if (!_contents)
    {
        _contents = @[[[CategoryManager sharedInstance] getLeagueArray]];
        
//        _contents = @[
//                      @[
//                          @[@"Section0_Row0", @"Row0_Subrow1",@"Row0_Subrow2"],
//                          @[@"Section1_Row0", @"Row0_Subrow1", @"Row0_Subrow2", @"Row0_Subrow3"],
//                          @[@"Section1_Row1"],
//                          @[@"Section1_Row2", @"Row2_Subrow1", @"Row2_Subrow2", @"Row2_Subrow3", @"Row2_Subrow4", @"Row2_Subrow5"],
//                          @[@"Section1_Row3"],
//                          @[@"Section1_Row4"],
//                          @[@"Section1_Row5"],
//                          @[@"Section1_Row6"],
//                          @[@"Section1_Row7"],
//                          @[@"Section1_Row8"],
//                          @[@"Section1_Row9"],
//                          @[@"Section1_Row10"],
//                          @[@"Section1_Row11"]]
//                      ];
    }
    
    return _contents;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.contents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contents[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.contents[indexPath.section][indexPath.row] count] - 1;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        return YES;
    }
    
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
    
    if ((indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 0)) || (indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == 2)))
        cell.expandable = YES;
    else
        cell.expandable = NO;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
}

#pragma mark - Actions

- (void)collapseSubrows
{
    [self.menuTableview collapseCurrentlyExpandedIndexPaths];
}

- (void)refreshData
{
    _contents = @[[[CategoryManager sharedInstance] getLeagueArray]];
    [self reloadTableViewWithData:_contents];
}

- (void)undoData
{
    [self reloadTableViewWithData:nil];
}

- (void)reloadTableViewWithData:(NSArray *)array
{
    self.contents = array;
    
    // Refresh data not scrolling
    //    [self.tableView refreshData];
    
    [self.menuTableview refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}


@end
