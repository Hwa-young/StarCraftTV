//
//  YTTableViewCell.m
//  StarCraftTV
//
//  Created by 고화영 on 6/30/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "YTTableViewCell.h"

@implementation YTTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.titleLabel sizeToFit];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
