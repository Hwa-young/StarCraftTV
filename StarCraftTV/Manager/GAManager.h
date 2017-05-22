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

+ (void)startTracker;

+ (void)stopTracker;

+ (void)trackWithView:(NSString*)titleString;

@end
