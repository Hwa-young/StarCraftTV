//
//  UIImageView+Additions.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 12. 26..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "UIImageView+Additions.h"

@implementation UIImageView (Additions)

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage
{
	static dispatch_queue_t imageQueue;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		imageQueue = dispatch_queue_create("Image Queue", NULL);
	});
	
	
//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//		UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self getThumbImageURL]]];
//		dispatch_async(dispatch_get_main_queue(), ^{
//			self.indicator.hidden = YES;
//			[UIView transitionWithView:self.thumbImageView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//				self.thumbImageView.image = image;
//			} completion:nil];
//		});
//	});
	
	self.image = placeholderImage;
	
//	dispatch_async(imageQueue, ^{
//		UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//		dispatch_async(dispatch_get_main_queue(), ^{
//			
//		});
//	});
}

@end
