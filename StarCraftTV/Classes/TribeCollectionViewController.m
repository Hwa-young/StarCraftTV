//
//  TribeCollectionViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 6. 23..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "TribeCollectionViewController.h"
#import "TribeCollectionViewCell.h"

#import "YouTubeAPIHelper.h"

#import "CategoryManager.h"

#import "VideoListTableViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>


@interface TribeCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *peopleList;
@property (nonatomic, strong) NSString *qString;

@property (strong, nonatomic) YouTubeAPIHelper *youtubeAPI;

@end

@implementation TribeCollectionViewController

static NSString * const reuseIdentifier = @"TribeCollectionViewCell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(TRIBE_TYPE)tribeType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self.navigationItem setTitle:@"인물 검색"];
        
        _tType = tribeType;
        [self makeTribeList];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//    [self.collectionView registerClass:[TribeCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TribeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TribeCollectionViewCell"];
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
//    CGRect f = [self.collectionView frame];
//    f.size.height -= 50;
////    f.origin.y += 50;
//    [self.collectionView setFrame:f];

    UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout*)self.collectionViewLayout;
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    flowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 50.f);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.itemSize = CGSizeMake(100, 50);
    
    self.collectionView.collectionViewLayout = flowLayout;
    
    self.dropMenu = [[KPDropMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50.f)];
    self.dropMenu.delegate = self;
    self.dropMenu.items = @[@"테란", @"프로토스", @"저그", @"전체"];
    self.dropMenu.backgroundColor = [UIColor whiteColor];
    self.dropMenu.title = @"종족";
    self.dropMenu.titleColor = [UIColor redColor];
    self.dropMenu.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
    self.dropMenu.titleTextAlignment = NSTextAlignmentCenter;
    self.dropMenu.DirectionDown = YES;
    
    [self.collectionView addSubview:self.dropMenu];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeTribeList
{
    _peopleList = [[NSMutableArray alloc] init];
    
    if(_tType == TAG_TRIBE_TERRAN)
        _peopleList = [[CategoryManager sharedInstance] getTerranProgamerList];
    else if(_tType == TAG_TRIBE_PROTOSS)
        _peopleList = [[CategoryManager sharedInstance] getProtossProgamerList];
    else if(_tType == TAG_TRIBE_ZERG)
        _peopleList = [[CategoryManager sharedInstance] getZergProgamerList];
    else
        _peopleList = [[CategoryManager sharedInstance] getProgamerList];
}

- (void)didSelectItem:(KPDropMenu *)dropMenu atIndex:(int)atIndex
{
    [SVProgressHUD show];
    
    if(atIndex == 0)
        _peopleList = [[CategoryManager sharedInstance] getTerranProgamerList];
    else if(atIndex == 1)
        _peopleList = [[CategoryManager sharedInstance] getProtossProgamerList];
    else if(atIndex == 2)
        _peopleList = [[CategoryManager sharedInstance] getZergProgamerList];
    else if(atIndex == 3)
        _peopleList = [[CategoryManager sharedInstance] getProgamerList];

    [self.collectionView reloadData];
    [SVProgressHUD dismiss];
    
//    NSLog(@"didSelectItem : %d", atIndex);
}

#pragma mark <UICollectionViewDataSource>

/*
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        float headerHeight = 50.f;
        
        if (reusableview==nil) {
            reusableview=[[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, headerHeight)];
        }
        
        if(!self.dropMenu)
        {
            self.dropMenu = [[KPDropMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50.f)];
            self.dropMenu.delegate = self;
            self.dropMenu.items = @[@"테란", @"프로토스", @"저그", @"전체"];
            self.dropMenu.backgroundColor = [UIColor whiteColor];
            self.dropMenu.title = @"종족";
            self.dropMenu.titleColor = [UIColor redColor];
            self.dropMenu.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
            self.dropMenu.titleTextAlignment = NSTextAlignmentCenter;
            self.dropMenu.DirectionDown = YES;
            
            [reusableview addSubview:self.dropMenu];
        }
        return reusableview;
    }
    return nil;
}
*/

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 50.f);
}
 */

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_peopleList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TribeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.nameLabel.text = [_peopleList objectAtIndex:indexPath.row];
    [cell.nameLabel setTextColor:[UIColor blackColor]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self makeQueryString:[_peopleList objectAtIndex:indexPath.row]];
    
    [self callYoutubeSearchApiWithSearchString:_qString];
}

- (void)makeQueryString:(NSString*)str
{
    _qString = str;
}

- (void)callYoutubeSearchApiWithSearchString:(NSString*)qString
{
    [SVProgressHUD show];
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:qString forKey:@"q"];
    
    self.youtubeAPI = [[YouTubeAPIHelper alloc] init];
    
    [self.youtubeAPI settingAccessToken:@""];
    [self.youtubeAPI.paramaters addEntriesFromDictionary:param];
    
    [self.youtubeAPI getListPlaylistInChannel:@"UCX1DpoQkBN4rv5ZfPivA_Wg" completion:^(BOOL success, NSError *error) {
        if (success) {
            [SVProgressHUD dismiss];
            
            if([self.youtubeAPI.searchItem.items count]==0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"검색조건에 맞는 프로게이머 동영상이 존재하지 않습니다." delegate:self
                                                      cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            
            VideoListTableViewController *vList = [[VideoListTableViewController alloc] initWithFilterHeader:NO];
            [vList setQueryString:qString];
            [vList setChannelID:@"UCX1DpoQkBN4rv5ZfPivA_Wg"];
            [self.navigationController pushViewController:vList animated:YES];
        }
    }];
}

@end
