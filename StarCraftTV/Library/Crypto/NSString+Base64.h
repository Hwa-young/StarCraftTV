//
//  NSString+Base64.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 25..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;

+ (NSString *)stringWithBase64EncodedString:(NSString *)string;

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

- (NSString *)base64EncodedString;

- (NSString *)base64DecodedString;

- (NSData *)base64DecodedData;

@end
