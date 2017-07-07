//
//  YTTableViewCell.h
//  StarCraftTV
//
//  Created by 고화영 on 6/30/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTItem.h"

@interface YTTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)setTabelviewCell:(YTItem*)item;

@end
