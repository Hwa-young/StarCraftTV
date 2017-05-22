//
//  TF_Core.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 14..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#ifndef STARCRAFTTV_TF_Core_h
#define STARCRAFTTV_TF_Core_h

#import "TF_Additions.h"
#import "TF_Singleton.h"
#import "GAManager.h"
#import <sys/utsname.h>


// iOS 버전 체크

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SCREEN_WIDTH_MAIN ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT_MAIN ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH_MAIN, SCREEN_HEIGHT_MAIN))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH_MAIN, SCREEN_HEIGHT_MAIN))

// iPad/iPhone 판별
#define IS_IPAD             ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE           ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define IS_IPHONE5			(IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
// (([[UIScreen mainScreen] bounds].size.height-568) ? NO : YES)
#define IS_IPHONE6          (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE6P         (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//#define IS_OS_5_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
//#define IS_OS_6_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
//#define IS_OS_6_LESS        ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0)
//#define IS_OS_7_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//#define IS_OS_8_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//#define IS_OS_7_0           ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.1)

#define IS_OS_5_OR_LATER	SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")
#define IS_OS_6_OR_LATER	SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")
#define IS_OS_6_LESS        SYSTEM_VERSION_LESS_THAN(@"6.0")
#define IS_OS_7_OR_LATER	SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define IS_OS_8_OR_LATER	SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define IS_OS_9_OR_LATER	SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")

#define IS_OS_7_0           SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0") && SYSTEM_VERSION_LESS_THAN(@"7.1")

#define DEBUG_LAYOUT(v)     v.layer.borderColor = [UIColor blackColor].CGColor;v.layer.borderWidth=2
#define DEBUG_LAYOUT_R(v)     v.layer.borderColor = [UIColor redColor].CGColor;v.layer.borderWidth=2
#define DEBUG_LAYOUT_G(v)     v.layer.borderColor = [UIColor greenColor].CGColor;v.layer.borderWidth=2
#define DEBUG_LAYOUT_B(v)     v.layer.borderColor = [UIColor blueColor].CGColor;v.layer.borderWidth=2
#define DEBUG_LAYOUT_Y(v)     v.layer.borderColor = [UIColor yellowColor].CGColor;v.layer.borderWidth=2

// iOS7 버전에 따른 y값 계산 매크로
#define VAL_7(...)	IS_OS_7_OR_LATER ? (20 + __VA_ARGS__) : (__VA_ARGS__)

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

//#define IS_IPHONE_6_HW      [machineName() isEqualToString:@"iPhone7,2"]
//#define IS_IPHONE_6_PLUS_HW [machineName() isEqualToString:@"iPhone7,1"]
//
//NSString* machineName()
//{
//    static NSString* name = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        struct utsname systemInfo;
//        uname(&systemInfo);
//        name = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
//    });
//    return name;
//}
#endif
