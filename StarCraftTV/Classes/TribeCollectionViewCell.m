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
    self.layer.borderColor = [UIColor redColor].CGColor;;
}

@end
