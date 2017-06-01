//
//  UIButton+Animation.m
//  tving
//
//  Created by HYKO on 2016. 10. 2..
//  Copyright (c) 2016년 CJ E&M. All rights reserved.
//

#import "UIButton+Animation.h"


@implementation UIButton (Animation)

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
    {
        self.backgroundColor = [UIColor redColor];
    }
    else
    {
        self.backgroundColor = [UIColor orangeColor];
    }
}

- (void)setSelected:(BOOL)selected
{
    //NSLog(@"Selected");
}

@end
