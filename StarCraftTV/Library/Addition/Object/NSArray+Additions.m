//
//  NSArray+Additions.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 12. 5..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

- (NSArray *)reversedArray
{
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	NSEnumerator *enumerator = [self reverseObjectEnumerator];
	for (id element in enumerator) {
		[array addObject:element];
	}
	return [NSArray arrayWithArray:array];
}

@end
