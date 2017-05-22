//
//  NSDate+Additions.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 14..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "NSDate+Additions.h"

static NSDateFormatter * g_pDateFormatter = nil;

@implementation NSDate (Additions)

+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format
{
    if ( g_pDateFormatter == nil )
    {
        g_pDateFormatter = [[NSDateFormatter alloc] init];
    }
	[g_pDateFormatter setDateFormat:format];
    [g_pDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Seoul"]];
	NSDate *date = [g_pDateFormatter dateFromString:string];
	return date;
}

+ (NSDate *)dateFromString:(NSString *)string
{
	return [NSDate dateFromString:string format:[NSDate timestampFormatString]];
}

- (NSString *)stringWithFormat:(NSString *)format
{
    if ( g_pDateFormatter == nil )
    {
        g_pDateFormatter = [[NSDateFormatter alloc] init];
    }
	[g_pDateFormatter setDateFormat:format];
	NSString *str = [g_pDateFormatter stringFromDate:self];
	return str;
}

- (NSString *)string
{
	return [self stringWithFormat:[NSDate timestampFormatString]];
}

- (BOOL)between:(NSDate *)sd and:(NSDate *)ed
{
    if ([self compare:sd] == NSOrderedDescending && [self compare:ed] == NSOrderedAscending)
		return YES;
	return NO;
}

- (BOOL)after:(NSDate *)sd
{
    if ([self compare:sd] == NSOrderedDescending)
		return YES;
	return NO;
}

- (BOOL)before:(NSDate *)ed
{
    if ([self compare:ed] == NSOrderedAscending)
        return YES;
    return NO;
}

- (NSString*) commentStringWithWritingTime
{
    NSDate* currentDate = [NSDate date];
    NSTimeInterval secondsBetween = [currentDate timeIntervalSinceDate:self];
    if (secondsBetween < 60) // 1분 이내
    {
        return @"방금 전";
    }
    if (secondsBetween < 60*60) // 1시간 이내
    {
        NSString* retStr = [NSString stringWithFormat:@"%2d분 전",(int)(floor(secondsBetween/60.0f))+1];
        return retStr;
    }
    if (secondsBetween < 60*60*24) // 24시간 이내
    {
        NSString* retStr = [NSString stringWithFormat:@"%2d시간 전",(int)(floor(secondsBetween/60.0f/60.0f))+1];
        return retStr;
    }
    NSString* retStr = [NSString stringWithFormat:@"%2d일 전",(int)(floor(secondsBetween/60.0f/60.0f/24.0f))+1];
    return retStr;
    
    return [self stringWithFormat:@"yyyy.MM.dd"];
}

- (int) getYear
{
    NSCalendarUnit units = NSCalendarUnitYear;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:units fromDate:self];
    
    return (int)[components year];
}

+ (NSString *)dateFormatString {
	return @"yyyy-MM-dd";
}

+ (NSString *)timeFormatString {
	return @"HH:mm:ss";
}

+ (NSString *)timestampFormatString {
	return @"yyyy-MM-dd HH:mm:ss";
}





@end
