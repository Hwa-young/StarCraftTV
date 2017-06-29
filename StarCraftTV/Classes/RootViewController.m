//
//  RootViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "RootViewController.h"

#import "YoutubeListViewController.h"
#import "SettingViewController.h"
#import "CategoryListViewController.h"
#import "Constants.h"

//#import <TLYShyNavBar/TLYShyNavBarManager.h>

@import GoogleMobileAds;

//#import <GoogleMobileAds/GoogleMobileAds.h>
//#import <GoogleMobileAds/GADAdSize.h>
//#import <GoogleMobileAds/GADInterstitial.h>

@implementation CustomToolBar

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, HEIGHT_BANNER);
}

@end


@interface RootViewController () <GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation RootViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

        
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-60, -60) forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:19]}];
        
        SettingViewController *settingViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        CategoryListViewController *categoryViewController = [[CategoryListViewController alloc] initWithNibName:@"CategoryListViewController" bundle:nil];
        YoutubeListViewController *listViewController = [[YoutubeListViewController alloc] initWithNibName:@"YoutubeListViewController" bundle:nil];
        
        // SetViewController
        self.leftViewController = settingViewController;
        self.rightViewController = categoryViewController;
        self.centerViewController = listViewController;
        
        // AD Banner
        self.mBannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, HEIGHT_BANNER)];
        self.mBannerView.delegate = self;
        
        // Toolbar
        self.navigationController.toolbar.frame = CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, HEIGHT_BANNER);
        [self.navigationController setToolbarHidden:NO];
        [self.navigationController.toolbar addSubview:self.mBannerView];

        // Title
        [self.navigationItem setTitle:@"StarCraft TV"];
        NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:21]};
        [[self.navigationController navigationBar] setTitleTextAttributes:attributes];

        [self loadADdata];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.interstitial = [self createAndLoadInterstitial];
}

- (GADInterstitial *)createAndLoadInterstitial
{
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-4829113648689267~3448799853"];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    self.interstitial = [self createAndLoadInterstitial];
}

- (void)loadADdata
{
    self.mBannerView.adUnitID = @"ca-app-pub-4829113648689267/4925533053";
    self.mBannerView.rootViewController = self;
//    [self.bannerView loadRequest:[GADRequest request]];
    
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.
    request.testDevices = @[kGADSimulatorID];
    [self.mBannerView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)openCategoryViewController:(id)sender
{
    if(self.openSide == IIViewDeckSideRight || self.openSide == IIViewDeckSideLeft)
        [self closeSide:YES];
    else
        [self openSide:IIViewDeckSideRight animated:YES];
}

- (IBAction)openSettingViewController:(id)sender
{
    if(self.openSide == IIViewDeckSideRight || self.openSide == IIViewDeckSideLeft)
        [self closeSide:YES];
    else
        [self openSide:IIViewDeckSideLeft animated:YES];
}

#pragma mark GADBannerViewDelegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSLog(@"adViewDidReceiveAd");
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"didFailToReceiveAdWithError");
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView
{
    NSLog(@"adViewWillPresentScreen");
}

- (void)adViewWillDismissScreen:(GADBannerView *)bannerView
{
    NSLog(@"adViewWillDismissScreen");
}

- (void)adViewDidDismissScreen:(GADBannerView *)bannerView
{
    NSLog(@"adViewDidDismissScreen");
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView
{
    NSLog(@"adViewWillLeaveApplication");
}

@end
