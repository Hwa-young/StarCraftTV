//
//  NSMutableArray+Additions.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 12. 5..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "NSMutableArray+Additions.h"

@implementation NSMutableArray (Additions)

- (void)reverse
{
	NSUInteger i = 0;
	NSUInteger j = [self count] - 1;
	while (i < j) {
		[self exchangeObjectAtIndex:i withObjectAtIndex:j];
		i++;
		j--;
	}
}

@end
