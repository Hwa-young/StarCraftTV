//
//  UIApplication+Additions.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 12. 3..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Additions)

+ (CGSize)currentSize;

+ (CGSize)sizeInOrientation:(UIInterfaceOrientation)orientation;

+ (NSString *)docPath;

+ (void)openURL:(NSString *)url;

@end
