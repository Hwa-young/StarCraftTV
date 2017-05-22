//
//  NSString+Additions.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (NSString *)URLEncodedString;

- (NSString *)URLDecodedString;

- (BOOL)equalsIgnoreCaseString:(NSString *)aString;

- (NSString *)groupingString;

+ (NSString *)groupingStringWithInt:(int)in_nValue;

+ (NSString *)groupingStringWithLongLong:(long long)in_nValue;

@end
