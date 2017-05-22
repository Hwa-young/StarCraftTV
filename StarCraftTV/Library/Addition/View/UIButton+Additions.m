//
//  UIButton+Additions.m
//  tving
//
//  Created by mandolin on 2014. 10. 2..
//  Copyright (c) 2016년 CJ E&M. All rights reserved.
//

#import "UIButton+Additions.h"
#import "TF_Core.h"

@implementation UIButton (Additions)

- (void)setHighlighted:(BOOL)highlighted {
 
    if (self.tag >= 30000)
        return;
    if ([self imageForState:UIControlStateNormal] != nil)
        return;
    
    if ([self backgroundImageForState:UIControlStateNormal] != nil)
        return;
    
//    if (IS_OS_7_OR_LATER)
//    {
    
        
//    }
   
    NSString* title = [self titleForState:UIControlStateNormal];
    NSString* selectedTittle = [self titleForState:UIControlStateSelected];
    
    if ((title == nil || [title isEqualToString:@""]) && (selectedTittle == nil || [selectedTittle isEqualToString:@""]))
    {
        [super setHighlighted:highlighted];
        if (highlighted) {
            if ([self.backgroundColor isEqual:[UIColor clearColor]])
                self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        } else
        {
            if ([UIColor colorWithRed:0 green:0 blue:0 alpha:0.1])
                self.backgroundColor = [UIColor clearColor];
        }
    }
}

@end
