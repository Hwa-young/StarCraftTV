//
//  NSNumber+Additions.h
//  tving
//
//  Created by CuSinger on 2014. 8. 27..
//  Copyright (c) 2016년 CJ E&M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Additions)

- (NSString *)groupingString;

+ (NSString *)groupingStringWithInt:(int)in_nValue;

@end
