//
//  RootViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "RootViewController.h"

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

@end
