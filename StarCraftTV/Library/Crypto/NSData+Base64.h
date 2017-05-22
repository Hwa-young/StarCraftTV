//
//  NSData+Base64.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 25..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

+ (NSData *)base64DataFromString:(NSString *)string;

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

- (NSString *)base64EncodedString;

@end
