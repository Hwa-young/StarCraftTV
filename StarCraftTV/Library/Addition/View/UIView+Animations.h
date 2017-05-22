//
//  UIView+Animations.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 12. 5..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animations)

- (void)moveTo:(CGPoint)point duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

- (void)moveTo:(CGPoint)point duration:(NSTimeInterval)duration;

- (void)moveCenterTo:(CGPoint)point duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

- (void)moveCenterTo:(CGPoint)point duration:(NSTimeInterval)duration;

- (void)addSubview:(UIView *)view animated:(BOOL)animated;

@end
