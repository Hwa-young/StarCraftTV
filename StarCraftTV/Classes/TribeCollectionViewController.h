//
//  TribeCollectionViewController.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 6. 23..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "KPDropMenu.h"

@interface TribeCollectionViewController : UICollectionViewController <KPDropMenuDelegate>

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(TRIBE_TYPE)tribeType;

@property (nonatomic, assign) TRIBE_TYPE tType;
@property (strong, nonatomic) KPDropMenu        *dropMenu;

@end
