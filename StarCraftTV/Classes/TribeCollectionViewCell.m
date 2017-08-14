//
//  TribeCollectionViewCell.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 6. 23..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "TribeCollectionViewCell.h"

@implementation TribeCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:28.f/255.f green:30.f/255.f blue:27.f/255.f alpha:1.f].CGColor;;
}

@end
