//
//  NSString+Additions.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSString *)URLEncodedString
{
    __autoreleasing NSString *encodedString;
    NSString *originalString = (NSString *)self;
    encodedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
																						  NULL,
																						  (__bridge CFStringRef)originalString,
																						  NULL,
																						  (CFStringRef)@":!*();@/&?#[]+$,='%’\"",
																						  kCFStringEncodingUTF8
																						  );
    return encodedString;
}

- (NSString *)URLDecodedString
{
    __autoreleasing NSString *decodedString;
    NSString *originalString = (NSString *)self;
    decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
																										  NULL,
																										  (__bridge CFStringRef)originalString,
																										  CFSTR(""),
																										  kCFStringEncodingUTF8
																										  );
    return decodedString;
}

- (BOOL)equalsIgnoreCaseString:(NSString *)aString
{
	return [self caseInsensitiveCompare:aString] == NSOrderedSame;
}

+ (NSString *)groupingStringWithInt:(int)in_nValue
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setUsesGroupingSeparator:YES];
    NSNumber* viewCntNum = [NSNumber numberWithInt:in_nValue];

    return [numberFormatter stringFromNumber:viewCntNum];
}

+ (NSString *)groupingStringWithLongLong:(long long)in_nValue
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setUsesGroupingSeparator:YES];
    NSNumber* viewCntNum = [NSNumber numberWithLongLong:in_nValue];

    return [numberFormatter stringFromNumber:viewCntNum];
}

- (NSString *)groupingString
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setUsesGroupingSeparator:YES];
    NSNumber* viewCntNum = [numberFormatter numberFromString:self];

    return [numberFormatter stringFromNumber:viewCntNum];
}
@end
