//
//  VideoListCollectionViewController.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoListCollectionViewController : UICollectionViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong,nonatomic) NSMutableArray* videoArray;

@end
