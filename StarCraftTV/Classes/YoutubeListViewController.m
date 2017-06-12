//
//  YoutubeViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "YoutubeListViewController.h"
#import "CollectionViewCell.h"
#import "YoutubeViewController.h"

#import <TLYShyNavBar/TLYShyNavBarManager.h>

@interface YoutubeListViewController ()

@end

@implementation YoutubeListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self loadADdata];
    // Do any additional setup after loading the view from its nib.
    
    self.shyNavBarManager.scrollView = self.mCollectionView;
    self.shyNavBarManager.scrollView.scrollsToTop = YES;
    
    [self.mCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    self.mCollectionView.alwaysBounceVertical = YES;
    self.mCollectionView.backgroundColor = [UIColor redColor];
    
//    UICollectionViewFlowLayout *flow =(UICollectionViewFlowLayout*)self.mCollectionView.collectionViewLayout;
//    flow.sectionHeadersPinToVisibleBounds = YES;
//    flow.sectionInset = UIEdgeInsetsMake(18, 18, 4, 18);
//    flow.minimumInteritemSpacing = 4.0f;
//    flow.minimumLineSpacing = 4.0f;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.mCollectionView.scrollsToTop = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 2, 0);
//    return UIEdgeInsetsMake(18, 18, 4, 18);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    float resizedWidth = collectionView.frame.size.width;
//    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) collectionViewLayout;
//    if (IS_IPAD)
//    {
//        resizedWidth = (resizedWidth - (layout.minimumInteritemSpacing * 5) - 100) / 5;
//    }
//    else
//    {
//        resizedWidth = (resizedWidth - (layout.minimumInteritemSpacing * 2) - 36) / 3;
//    }
//
//    resizedWidth = floorf(resizedWidth);
//
//    float resizedHeight = resizedWidth / (110.f / 159.f);
//    return CGSizeMake(resizedWidth, resizedHeight);
    
    return CGSizeMake(375, 100);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Test
    return 1;
    
    // returm model.items.count
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"CollectionViewCell";
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor lightGrayColor]];
    return  cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YoutubeViewController *controller = [[YoutubeViewController alloc] initWithNibName:@"YoutubeViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
