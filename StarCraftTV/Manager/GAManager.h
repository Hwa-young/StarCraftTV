//
//  GAManager.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TF_Core.h"

@interface GAManager : NSObject

AS_SINGLETON(GAManager)

+ (void)trackWithView:(NSString*)titleString;
+ (void)startTrackingSession;
+ (void)endTrackingSession;
+ (void)dispatchUsingBackgroundTask;


@end
