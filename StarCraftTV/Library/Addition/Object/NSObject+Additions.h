//
//  NSObject+Additions.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 15..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Additions)

- (void)logProperties;

- (void)performSelector:(SEL)selector andReturnTo:(void *)returnData withArguments:(void **)arguments;

- (void)performSelector:(SEL)selector withArguments:(void **)arguments;

- (void)performSelectorIfExists:(SEL)selector andReturnTo:(void *)returnData withArguments:(void **)arguments;

- (void)performSelectorIfExists:(SEL)selector withArguments:(void **)arguments;

@end
