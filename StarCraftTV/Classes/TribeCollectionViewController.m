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
    [self.collectionView registerClass:[TribeCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TribeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TribeCollectionViewCell"];
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];

//    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.collectionViewLayout;
    UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout*)self.collectionViewLayout;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.itemSize = CGSizeMake(100, 50);
    
    self.collectionView.collectionViewLayout = flowLayout;
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

#pragma mark <UICollectionViewDataSource>

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
            
            VideoListTableViewController *vList = [[VideoListTableViewController alloc] initWithFilterHeader:NO];
            [vList setQueryString:qString];
            [self.navigationController pushViewController:vList animated:YES];
        }
    }];
}

@end
