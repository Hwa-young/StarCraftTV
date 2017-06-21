//
//  CategoryListViewController.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
#import "SKSTableViewCell.h"

@interface CategoryListViewController : UIViewController <SKSTableViewDelegate>

@property (weak, nonatomic) IBOutlet SKSTableView *menuTableview;

@end
