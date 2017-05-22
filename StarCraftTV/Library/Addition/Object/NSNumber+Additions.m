//
//  NSNumber+Additions.m
//  tving
//
//  Created by CuSinger on 2014. 8. 27..
//  Copyright (c) 2016년 CJ E&M. All rights reserved.
//

#import "NSNumber+Additions.h"

@implementation NSNumber (Additions)

+ (NSString *)groupingStringWithInt:(int)in_nValue
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setUsesGroupingSeparator:YES];
    NSNumber* viewCntNum = [NSNumber numberWithInt:in_nValue];

    return [numberFormatter stringFromNumber:viewCntNum];
}

- (NSString *)groupingString
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setUsesGroupingSeparator:YES];

    return [numberFormatter stringFromNumber:self];
}

@end
