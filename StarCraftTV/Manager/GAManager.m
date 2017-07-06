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

+ (void)trackWithView:(NSString*)titleString
{
    if((id)titleString == [NSNull null]) return;
    
    NSString* resultTitleString = titleString;
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    if([titleString isEqualToString:@"app start"])
        [tracker set:kGAISessionControl value:@"start"];
    
    [tracker send:[[[GAIDictionaryBuilder createScreenView] set:resultTitleString forKey:kGAIScreenName] build]];
    
    if (titleString.length == 0) {
        NSLog(@"Google Analytics Data not set");
    }
}

+ (void)startTrackingSession
{
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    [[GAI sharedInstance] trackerWithTrackingId:kTrackingId];
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    
    [tracker send:[[[GAIDictionaryBuilder createEventWithCategory:@"application_events"
                                                           action:@"application_session_start"
                                                            label:nil
                                                            value:nil] set:@"start" forKey:kGAISessionControl] build]];
    
    [tracker set:kGAISessionControl value:nil];
    
    [[GAI sharedInstance] dispatch];
}

+ (void)endTrackingSession
{
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[[GAIDictionaryBuilder createEventWithCategory:@"application_events"
                                                           action:@"application_session_end"
                                                            label:nil
                                                            value:nil] set:@"end" forKey:kGAISessionControl] build]];
    
    [tracker set:kGAISessionControl
           value:nil];
    
    [self dispatchUsingBackgroundTask];
}

+ (void)dispatchUsingBackgroundTask
{
    // As the end tracking session gets called when entering background, run it in a background task to make sure it gets dispatched
    UIApplication *app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask;
    
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[GAI sharedInstance] dispatch];
        
        double dispatchTimeout = 10.0;  // 10 seconds timeout
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dispatchTimeout * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [app endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
        });
    });
}

@end
