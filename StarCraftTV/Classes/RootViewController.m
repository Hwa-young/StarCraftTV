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

#import <SVProgressHUD/SVProgressHUD.h>

@import GoogleMobileAds;

@implementation CustomToolBar

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, HEIGHT_BANNER);
}

@end


@interface RootViewController () <GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial    *interstitial;
@property(nonatomic, assign) BOOL               isAnimate;

@end

@implementation RootViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        
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
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:21], NSFontAttributeName, nil]];

        [self loadADdata];
        
        self.isAnimate = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setConfigueHUD];

    self.interstitial = [self createAndLoadInterstitial];
    [self performSelector:@selector(callMainAD) withObject:nil afterDelay:1.5f];
}

- (void)setConfigueHUD
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMaximumDismissTimeInterval:1.f];
}

- (GADInterstitial *)createAndLoadInterstitial
{
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-4829113648689267/4656017850"];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    NSLog(@"interstitialDidDismissScreen");
    self.interstitial = [self createAndLoadInterstitial];
    
    [self updateFocusIfNeeded];
}

- (void)callMainAD
{
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    } else {
        NSLog(@"Ad wasn't ready");
    }
}

- (void)loadADdata
{
    self.mBannerView.adUnitID = @"ca-app-pub-4829113648689267/4925533053";
    self.mBannerView.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID];
    [self.mBannerView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)openCategoryViewController:(id)sender
{
    if(self.isAnimate == YES) return;
    if(self.openSide == IIViewDeckSideRight || self.openSide == IIViewDeckSideLeft)
    {
        self.isAnimate = YES;
        [self closeSide:YES];
        [self performSelector:@selector(changeAnimateFlagValue) withObject:self afterDelay:0.5f];
    }
    else
    {
        self.isAnimate = YES;
        [self openSide:IIViewDeckSideRight animated:YES];
        [self performSelector:@selector(changeAnimateFlagValue) withObject:self afterDelay:0.5f];
    }
}

- (IBAction)openSettingViewController:(id)sender
{
    if(self.isAnimate == YES) return;
    if(self.openSide == IIViewDeckSideRight || self.openSide == IIViewDeckSideLeft)
    {
        self.isAnimate = YES;
        [self closeSide:YES];
        [self performSelector:@selector(changeAnimateFlagValue) withObject:self afterDelay:0.5f];
    }
    else
    {
        self.isAnimate = YES;
        [self openSide:IIViewDeckSideLeft animated:YES];
        [self performSelector:@selector(changeAnimateFlagValue) withObject:self afterDelay:0.5f];
    }
}

- (void)changeAnimateFlagValue
{
    self.isAnimate = NO;
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
//    NSLog(@"adViewWillDismissScreen");
}

- (void)adViewDidDismissScreen:(GADBannerView *)bannerView
{
//    NSLog(@"adViewDidDismissScreen");
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView
{
//    NSLog(@"adViewWillLeaveApplication");
}

/// Called when an interstitial ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
}

/// Called when an interstitial ad request failed.
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Called just before presenting an interstitial.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
    
    //[viewAdd removeFromSuperview];
//    [self.view removeFromSuperview];
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store).
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
}

- (UIBarButtonItem*)getCategoryItem
{
    return self.categotyBarButton;
}

@end
