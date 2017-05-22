//
//  UIScrollView+Additions.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 20..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "UIScrollView+Additions.h"

@implementation UIScrollView (Additions)

- (NSInteger)pageNumberByHorizontal
{
	CGFloat pageWidth = self.frame.size.width;
	int page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth + 1);
	return page;
}

- (NSInteger)totalPageNumberByHorizontal
{
	CGFloat pageWidth = self.frame.size.width;
	int page = self.contentSize.width / pageWidth;
	return page;
}

- (NSInteger)pageNumberByVertical
{
	CGFloat pageHeight = self.frame.size.height;
	int page = floor((self.contentOffset.y - pageHeight / 2) / pageHeight + 1);
	return page;
}

- (void)scrollHorizontalToPageNo:(NSInteger)pageNo animated:(BOOL)animated
{
	CGRect frame = self.frame;
	frame.origin.x = frame.size.width * pageNo;
	frame.origin.y = 0;
	[self scrollRectToVisible:frame animated:animated];
}

- (void)scrollVerticalToPageNo:(NSInteger)pageNo animated:(BOOL)animated
{
	CGRect frame = self.frame;
	frame.origin.x = 0;
	frame.origin.y = frame.size.height * pageNo;
	[self scrollRectToVisible:frame animated:animated];
}

@end
