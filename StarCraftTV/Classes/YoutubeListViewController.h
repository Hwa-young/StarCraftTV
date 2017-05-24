//
//  YoutubeViewController.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YoutubeListViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;

@end
