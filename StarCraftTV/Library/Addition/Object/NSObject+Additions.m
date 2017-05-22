//
//  NSObject+Additions.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 15..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "NSObject+Additions.h"
#import <objc/runtime.h>

@implementation NSObject (Additions)

- (void)logProperties {
	NSLog(@"");
    NSLog(@"Properties for object %@", self);
    @autoreleasepool {
        unsigned int numberOfProperties = 0;
        objc_property_t *propertyArray = class_copyPropertyList([self class], &numberOfProperties);
        for (NSUInteger i = 0; i < numberOfProperties; i++) {
            objc_property_t property = propertyArray[i];
            NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
            NSLog(@"%@ : %@", name, [self valueForKey:name]);
        }
        free(propertyArray);
    }
}

- (void)performSelector:(SEL)selector andReturnTo:(void *)returnData withArguments:(void **)arguments {
	NSMethodSignature *methodSignature = [self methodSignatureForSelector:selector];
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	[invocation setSelector:selector];
	
	NSUInteger argCount = [methodSignature numberOfArguments];
	
	for (int i=2; i < argCount; i++) {
		void *arg = arguments[i-2];
		[invocation setArgument:arg atIndex:i];
	}
	
	[invocation invokeWithTarget:self];
	if(returnData != NULL) {
		[invocation getReturnValue:returnData];
	}
}

- (void)performSelector:(SEL)selector withArguments:(void **)arguments {
	[self performSelector:selector andReturnTo:NULL withArguments:arguments];
}

- (void)performSelectorIfExists:(SEL)selector andReturnTo:(void *)returnData withArguments:(void **)arguments {
	if([self respondsToSelector:selector]) {
		[self performSelector:selector andReturnTo:returnData withArguments:arguments];
	}
}

- (void)performSelectorIfExists:(SEL)selector withArguments:(void **)arguments {
	[self performSelectorIfExists:selector andReturnTo:NULL withArguments:arguments];
}


@end
