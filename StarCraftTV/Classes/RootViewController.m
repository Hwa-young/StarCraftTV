//
//  RootViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "RootViewController.h"
#import "CollectionViewCell.h"

#import <TLYShyNavBar/TLYShyNavBarManager.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shyNavBarManager.scrollView = self.mCollectionView;
    
    // request google admob banner view
    [self loadADdata];
    
    [self.mCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    self.mCollectionView.alwaysBounceVertical = YES;
    self.mCollectionView.scrollsToTop = NO;
    
    UICollectionViewFlowLayout *flow =(UICollectionViewFlowLayout*)self.mCollectionView.collectionViewLayout;
    flow.sectionHeadersPinToVisibleBounds = YES;
    flow.sectionInset = UIEdgeInsetsMake(18, 18, 4, 18);
    flow.minimumInteritemSpacing = 4.0f;
    flow.minimumLineSpacing = 4.0f;
}

- (void)loadADdata
{
//    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    self.bannerView.adUnitID = @"ca-app-pub-4829113648689267/4925533053";
    self.bannerView.rootViewController = self;
//    [self.bannerView loadRequest:[GADRequest request]];
    
    
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.
    request.testDevices = @[kGADSimulatorID];
    [self.bannerView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(18, 18, 4, 18);
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

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeZero;
//}

- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
//    {
//    }
//    return nil;
//}

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
    NSLog(@"%ld", (long)indexPath.row);
}

@end
