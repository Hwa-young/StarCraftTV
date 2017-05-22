//
//  UIColor+Additions.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 14..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef	COLOR_RGB
#define	COLOR_RGB(R,G,B)	[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]
#undef	COLOR_RGBA
#define COLOR_RGBA(R,G,B,A)	[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#undef	COLOR_HEX
#define COLOR_HEX(V)		[UIColor colorFromHexString:V]
#undef	COLOR_HEXA
#define COLOR_HEXA(V,A)		[UIColor colorFromHexString:V alpha:A]


@interface UIColor (Additions)

/**
 @brief 헥사코드를 UIColor로 변경하는 매크로 3, 6자리 값을 모두 처리한다.
 @author HYKo
 */
+ (UIColor *) colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 @brief 헥사코드를 UIColor로 변경하는 매크로 3, 6자리 값을 모두 처리한다.
 @author HYKo
 */
+ (UIColor *) colorFromHexString:(NSString *)hexString;

@end
