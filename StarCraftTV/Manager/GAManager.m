//
//  GAManager.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "GAManager.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "TF_Core.h"

NSString* const kTrackingId = @"UA-99564288-1";

@implementation GAManager

DEF_SINGLETON(GAManager)

- (id)init
{
	self = [super init];
	if (self) {
		
	}
	return self;
}

+ (void)startTracker
{
	[GAI sharedInstance].dispatchInterval = 20;
	[GAI sharedInstance].trackUncaughtExceptions = NO;
	[[GAI sharedInstance] trackerWithTrackingId:kTrackingId];
}

+ (void)stopTracker
{
    [self stopTracker];
}

+ (void)trackWithView:(NSString*)titleString
{
    if((id)titleString == [NSNull null]) return;
    
    NSString* resultTitleString = titleString;
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[GAIDictionaryBuilder createScreenView] set:resultTitleString
                                                         forKey:kGAIScreenName] build]];
    
    if (titleString.length == 0) {
        NSLog(@"Google Analytics Data not set");
    }
}

@end
