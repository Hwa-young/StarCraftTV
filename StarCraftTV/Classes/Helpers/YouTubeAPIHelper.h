//
//  YouTubeAPIHelper.h
//  StarCraftTV
//
//  Created by 고화영 on 7/10/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YoutubeSearchContants.h"
#import "YTSearchItem.h"

typedef void(^Completion)(BOOL success, NSError *error);

@interface YouTubeAPIHelper : NSObject

@property (strong, nonatomic) NSString *accessToken;
@property (nonatomic) URLType urlType;
@property (strong, nonatomic) NSMutableDictionary *paramaters;
@property (strong, nonatomic) YTSearchItem *searchItem;
@property (strong, nonatomic) NSMutableArray *resultSearchVideo;
@property (strong, nonatomic) YTSearchItem *searchChannel;
@property (strong, nonatomic) NSString *keySearchOld;

- (id)init;
- (void)settingAccessToken:(NSString *)accessToken;
- (void)getListVideoActivitied:(Completion)completion;
- (void)getListVideoInChannel:(NSString *)idChannel completion:(Completion)completion;
- (void)getListVideoByKeySearch:(NSString *)key completion:(Completion)completion;
- (void)getListVideoByPlayListWithType:(URLType)type completion:(Completion)completion;

- (void)getMyPlaylistItems;
- (void)getMySubscriptions:(void(^)(BOOL success, NSError *error))completion;
- (void)getChannelActivities:(void(^)(BOOL success, NSError *error))completion;

@end
