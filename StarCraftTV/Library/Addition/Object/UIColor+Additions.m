//
//  UIColor+Additions.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 14..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *) colorFromHexString:(NSString *)hexString
{
	return [UIColor colorFromHexString:hexString alpha:1.0f];
}

+ (UIColor *) colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
	NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
	if([cleanString length] == 3) {
		cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
					   [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
					   [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
					   [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
	}
	if([cleanString length] == 6) {
		cleanString = [cleanString stringByAppendingString:@"ff"];
	}
	
	unsigned int baseValue;
	[[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
	
	float red = ((baseValue >> 24) & 0xFF)/255.0f;
	float green = ((baseValue >> 16) & 0xFF)/255.0f;
	float blue = ((baseValue >> 8) & 0xFF)/255.0f;
	
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
