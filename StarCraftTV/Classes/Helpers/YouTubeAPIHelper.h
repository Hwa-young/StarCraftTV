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
#import "YTPlaylistItem.h"

typedef void(^Completion)(BOOL success, NSError *error);

@interface YouTubeAPIHelper : NSObject

@property (strong, nonatomic) NSString *accessToken;
@property (nonatomic) URLType urlType;
@property (strong, nonatomic) NSMutableDictionary *paramaters;
@property (strong, nonatomic) YTSearchItem *searchItem;
@property (strong, nonatomic) NSMutableArray *resultSearchVideo;
@property (strong, nonatomic) YTSearchItem *searchChannel;
@property (strong, nonatomic) NSString *keySearchOld;
@property (strong, nonatomic) YTPlaylistItem *playlistItem;

- (id)init;
- (void)settingAccessToken:(NSString *)accessToken;
- (void)getListVideoInChannel:(NSString *)idChannel completion:(Completion)completion;
- (void)getListPlaylistInChannel:(NSString *)idChannel completion:(Completion)completion;
- (void)getListPlaylistItemsInChannel:(NSString *)idChannel atQueryString:(NSString*)str completion:(Completion)completion;
- (void)getListVideoByKeySearch:(NSString *)key completion:(Completion)completion;
- (void)getListVideoByPlayListWithType:(URLType)type completion:(Completion)completion;

@end
