//
//  NSDictionary+Additions.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 15..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "NSDictionary+Additions.h"
#import "NSString+Additions.h"
//#import "ConfigManager.h"

@implementation NSDictionary (Additions)

- (NSObject *)objectAtPath:(NSString *)path
{
	return [self objectAtPath:path separator:nil];
}

- (NSObject *)objectAtPath:(NSString *)path separator:(NSString *)separator
{
	if ( nil == separator )	{
		path = [path stringByReplacingOccurrencesOfString:@"." withString:@"/"];
		separator = @"/";
	}
	
	NSArray *array = [path componentsSeparatedByString:separator];
	if ( 0 == [array count] ) {
		return nil;
	}
	
	NSObject *result = nil;
	NSDictionary *dict = self;
	
	for ( NSString *subPath in array ) {
		if ( 0 == [subPath length] )
			continue;
		
		result = [dict objectForKey:subPath];
		if ( nil == result )
			return nil;
		
		if ( [array lastObject] == subPath ) {
			return result;
		} else if ( NO == [result isKindOfClass:[NSDictionary class]] ) {
			return nil;
		}
		
		dict = (NSDictionary *)result;
	}
	
	return (result == [NSNull null]) ? nil : result;
}

- (BOOL)boolAtPath:(NSString *)path
{
	NSObject *obj = [self objectAtPath:path];
	if ( [obj isKindOfClass:[NSNull class]] ) {
		return NO;
	} else if ( [obj isKindOfClass:[NSNumber class]] ) {
		return [(NSNumber *)obj intValue] ? YES : NO;
	} else if ( [obj isKindOfClass:[NSString class]] ) {
		if ( [(NSString *)obj hasPrefix:@"y"] ||
			[(NSString *)obj hasPrefix:@"Y"] ||
			[(NSString *)obj hasPrefix:@"T"] ||
			[(NSString *)obj hasPrefix:@"t"] ||
			[(NSString *)obj isEqualToString:@"1"] )
		{
			return YES;
		}
		else
		{
			return NO;
		}
	}
	
	return NO;
}

- (NSNumber *)numberAtPath:(NSString *)path
{
	NSObject *obj = [self objectAtPath:path];
	if ( [obj isKindOfClass:[NSNull class]] ) {
		return nil;
	} else if ( [obj isKindOfClass:[NSNumber class]] ) {
		return (NSNumber *)obj;
	} else if ( [obj isKindOfClass:[NSString class]] ) {
		return [NSNumber numberWithDouble:[(NSString *)obj doubleValue]];
	}
	
	return nil;
}

- (NSString *)stringAtPath:(NSString *)path
{
	NSObject *obj = [self objectAtPath:path];
	if ( [obj isKindOfClass:[NSNull class]] ) {
		return nil;
	} else if ( [obj isKindOfClass:[NSNumber class]] ) {
		return [NSString stringWithFormat:@"%d", [(NSNumber *)obj intValue]];
	} else if ( [obj isKindOfClass:[NSString class]] ) {
		return (NSString *)obj;
	}
	
	return nil;
}

- (NSArray *)arrayAtPath:(NSString *)path
{
	NSObject *obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSArray class]] ? (NSArray *)obj : nil;
}

- (NSMutableArray *)mutableArrayAtPath:(NSString *)path
{
	NSObject *obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSMutableArray class]] ? (NSMutableArray *)obj : nil;
}

- (NSDictionary *)dictAtPath:(NSString *)path
{
	NSObject *obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSDictionary class]] ? (NSDictionary *)obj : nil;
}

- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path
{
	NSObject *obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSMutableDictionary class]] ? (NSMutableDictionary *)obj : nil;
}


-(NSString *)descriptionForObject:(NSObject *)obj locale:(id)locale indent:(NSUInteger)level
{
	NSString *objString = nil;
	
    if ([obj isKindOfClass:[NSString class]]) {
        objString = [NSString stringWithFormat:@"\"%@\"", (NSString *)obj];
    }
	else if ([obj isKindOfClass:[NSArray class]]) {
		objString = [(NSArray *)obj descriptionWithLocale:locale indent:level];
    }
	else if ([obj isKindOfClass:[NSDictionary class]]) {
		objString = [(NSDictionary *)obj descriptionWithLocale:locale indent:level];
    }
    else if ([obj respondsToSelector:@selector(descriptionWithLocale:)]) {
        objString = [obj performSelector:@selector(descriptionWithLocale:) withObject:locale];
    }
    else {
        objString = [obj description];
    }
	
    return objString;
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
	NSMutableString *log = [NSMutableString string];
	
    if ([self.allKeys count] == 0) {
        [log appendString:@"0 key/value pairs"];
    } else {
        [log appendString:@"{\n"];
		
        NSMutableString *indentString = [NSMutableString string];
        for (int i = 0; i < level; i++) {
            [indentString appendString:@"\t"];
        }
		
        id key = nil;
        for (int i = 0; i < [self count]; i++) {
            key = self.allKeys[i];
			
            [log appendFormat:@"\t%@%@ = %@", indentString,
             [self descriptionForObject:key locale:locale indent:level + 1],
             [self descriptionForObject:self[key] locale:locale indent:level + 1]];
			
            if (i + 1 < [self count]) {
                [log appendString:@",\n"];
            } else {
                [log appendString:@"\n"];
            }
        }
		
        [log appendFormat:@"%@}", indentString];
    }
	
    return log;
}

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)queryString
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *pairs = [queryString componentsSeparatedByString:@"&"];
	
    for (NSString *pair in pairs)
    {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if (elements.count >= 2)
		{
			NSRange range = [pair rangeOfString:@"="];
//            NSString *key = elements[0];
//            NSString *value = elements[1];
			NSString *key = [pair substringToIndex:range.location];
            NSString *value = [pair substringFromIndex:NSMaxRange(range)];
            NSString *decodedKey = [key URLDecodedString];
            NSString *decodedValue = [value URLDecodedString];
			
            if (![key isEqualToString:decodedKey])
                key = decodedKey;
			
            if (![value isEqualToString:decodedValue])
                value = decodedValue;
			
            [dictionary setObject:value forKey:key];
        }
    }
	
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

+ (NSDictionary *)dictionaryWithString:(NSString *)queryString
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *pairs = [queryString componentsSeparatedByString:@"&"];
	
    for (NSString *pair in pairs)
    {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if (elements.count >= 2)
		{
			NSRange range = [pair rangeOfString:@"="];
            //            NSString *key = elements[0];
            //            NSString *value = elements[1];
			NSString *key = [pair substringToIndex:range.location];
            NSString *value = [pair substringFromIndex:NSMaxRange(range)];
            NSString *decodedKey = key;
            NSString *decodedValue = value;
			
            if (![key isEqualToString:decodedKey])
                key = decodedKey;
			
            if (![value isEqualToString:decodedValue])
                value = decodedValue;
			
            [dictionary setObject:value forKey:key];
        }
    }
	
    return [NSDictionary dictionaryWithDictionary:dictionary];
}


- (NSString *)queryStringValue
{
    NSMutableArray *pairs = [NSMutableArray array];
    for (NSString *key in [self keyEnumerator])
    {
        id value = [self objectForKey:key];
        NSString *escapedValue = [value URLEncodedString];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escapedValue]];
    }
	
    return [pairs componentsJoinedByString:@"&"];
}

@end
