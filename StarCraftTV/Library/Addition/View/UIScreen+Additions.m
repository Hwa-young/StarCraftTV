//
//  UIScreen+Additions.m
//  StarCraftTV
//
//  Created by hug on 2014. 1. 2..
//  Copyright (c) 2014년 hug. All rights reserved.
//

#import "UIScreen+Additions.h"

@implementation UIScreen (Additions)

+ (CGRect) bounds
{
	return [[UIScreen mainScreen] bounds];
}

+ (CGRect) applicationFrame
{
	return [[UIScreen mainScreen] applicationFrame];
}

@end
