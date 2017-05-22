//
//  UIView+Animations.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 12. 5..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "UIView+Animations.h"
#import "UIView+Additions.h"

@implementation UIView (Animations)

- (void)moveTo:(CGPoint)point duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion
{
	[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self.origin = point;
	} completion:completion];
}

- (void)moveTo:(CGPoint)point duration:(NSTimeInterval)duration 
{
	[self moveTo:point duration:duration completion:nil];
}

- (void)moveCenterTo:(CGPoint)point duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion
{
	[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self.center = point;
	} completion:completion];
}

- (void)moveCenterTo:(CGPoint)point duration:(NSTimeInterval)duration
{
	[self moveCenterTo:point duration:duration completion:nil];
}


#pragma mark - 

- (void)addSubview:(UIView *)view animated:(BOOL)animated
{
	view.alpha = 0;
	[self addSubview:view];
	
	[UIView animateWithDuration:0.3 animations:^{
		view.alpha = 1;
	}];
}

@end
