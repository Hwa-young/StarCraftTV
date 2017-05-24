//
//  RootViewController.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ViewDeck/IIViewDeckController.h>
#import "BaseViewController.h"

@import GoogleMobileAds;

@interface RootViewController : IIViewDeckController

@property (weak, nonatomic) IBOutlet GADBannerView *mBannerView;

- (IBAction)openCategoryViewController:(id)sender;
- (IBAction)openSettingViewController:(id)sender;

@end
