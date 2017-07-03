//
//  AppDelegate.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "AppDelegate.h"
#import "CategoryManager.h"

#import <Crashlytics/Crashlytics.h>
#import <Fabric/Fabric.h>
#import <Google/Analytics.h>
#import <SDWebImage/SDWebImageManager.h>

#import "UIView_Custom.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [UIView Start];
    
    [[[SDWebImageManager sharedManager] imageCache] cleanDisk];
    [[[SDWebImageManager sharedManager] imageCache] setMaxCacheAge:60 * 60 * 24] ; // 하루만 캐쉬하도록 수정
    
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-4829113648689267~3448799853"];
    [FIRApp configure];
    
    // Fabric Start
    [Fabric with:@[[Crashlytics class]]];

    // Google Analytics Start
    [GAManager startTrackingSession];

    if (launchOptions == nil)
        [GAManager trackWithView:@"app start"];
    
    [self loadBootData];

    // Override point for customization after application launch.
    return YES;
}

- (void)loadBootData
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"boot" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    [CATEGORY_MANAGER saveCategoryDataWithDictionary:dicData];
    
    [[NSUserDefaults standardUserDefaults] setObject:dicData forKey:@"boot"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [GAManager endTrackingSession];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
