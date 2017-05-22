//
//  UIApplication+Additions.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 12. 3..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "UIApplication+Additions.h"

@implementation UIApplication (Additions)

+ (CGSize) currentSize
{
	return [UIApplication sizeInOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

+ (CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation
{
	CGSize size = [UIScreen mainScreen].bounds.size;
	UIApplication *application = [UIApplication sharedApplication];
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		size = CGSizeMake(size.height, size.width);
	}
	if (application.statusBarHidden == NO) {
		size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
	}
	return size;
}

+ (NSString *)docPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

+ (void)openURL:(NSString *)url
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
