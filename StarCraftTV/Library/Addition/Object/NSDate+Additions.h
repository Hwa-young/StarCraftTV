//
//  NSDate+Additions.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 14..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

/**
 @brief 포맷에 따른 문자열을 NSDate 객체로 반환한다.
 @author HYKo
 */
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format;

/**
 @brief timestamp 형식의 문자열을 NSDate로 형변환한다.
 @yyyy-MM-dd HH:mm:ss 여야 한다.
 @author HYKo
 */
+ (NSDate *)dateFromString:(NSString *)string;

/**
 @brief 포맷에 해당하는 문자열을 반환한다.
 @param format 문자열 포맷
 @author HYKo
 */
- (NSString *)stringWithFormat:(NSString *)format;

/**
 @brief timestamp 형식에 따른 문자열을 반환한다.
 @author HYKo
 */
- (NSString *)string;

/**
 @brief 두 날짜 사이에 있는지 BOOL값을 반환한다.
 @author HYKo
 */
- (BOOL)between:(NSDate *)sd and:(NSDate *)ed;

/**
 @brief 티빙톡/댓글용으로 날짜간 스트링을 생성하여 반환 (방금전, 1분전 등등)
 @author mandolin
*/

- (NSString*) commentStringWithWritingTime;

/**
 @brief 이후 날짜인지 BOOL값을 반환한다.
 @author mCoCoA
 */
- (BOOL)after:(NSDate *)sd;

/**
 @brief 이후 날짜인지 BOOL값을 반환한다.
 @author lolmzkim
 */
- (BOOL)before:(NSDate *)ed;

/** 
 @brief 년도 정보 추출
 */
- (int) getYear;

@end
