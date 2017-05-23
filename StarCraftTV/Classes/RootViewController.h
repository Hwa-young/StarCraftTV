//
//  RootViewController.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@import GoogleMobileAds;

@interface RootViewController : BaseViewController <UICollectionViewDelegate, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;

@end
