//
//  NSDictionary+Additions.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 15..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

/**
 @brief 키에 해당하는 오브젝트를 반환한다.
 하위 NSDictionary까지 . 형식을 이용하여 검색 가능하다.
 boolAtPath를 제외하고 키, 값이 없는경우 nil을 반환한다. boolAtPath는 NO를 반환한다.
 @author HYKo
 */
- (NSObject *)objectAtPath:(NSString *)path;

- (NSObject *)objectAtPath:(NSString *)path separator:(NSString *)separator;

- (BOOL)boolAtPath:(NSString *)path;

- (NSNumber *)numberAtPath:(NSString *)path;

- (NSString *)stringAtPath:(NSString *)path;

- (NSArray *)arrayAtPath:(NSString *)path;

- (NSMutableArray *)mutableArrayAtPath:(NSString *)path;

- (NSDictionary *)dictAtPath:(NSString *)path;

- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path;

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)queryString;
+ (NSDictionary *)dictionaryWithString:(NSString *)queryString;

- (NSString *)queryStringValue;

@end
