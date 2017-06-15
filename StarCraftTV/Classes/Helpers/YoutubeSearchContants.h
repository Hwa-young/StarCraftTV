//
//  StarCraftTVContants.h
//  StarCraftTV
//
//  Created by 고화영 on 7/9/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kAPI_KEY                   = @"AIzaSyAanh-c7aGoFdAEAX9Ie6QQXZBVQjpTrGg";

static NSString * const kSearchURL                 = @"https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=50&type=video&videoType=any&regionCode=KR&channelId=UCX1DpoQkBN4rv5ZfPivA_Wg";
static NSString * const kActivitiURL               = @"https://www.googleapis.com/youtube/v3/activities?part=contentDetails%2Csnippet&maxResults=50&channelId=UCX1DpoQkBN4rv5ZfPivA_Wg";
static NSString * const kChannelContentURL         = @"https://www.googleapis.com/youtube/v3/channels?part=contentDetails&mine=true";
static NSString * const kPlaylistItemURL           = @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50";
static NSString * const kSubscriptionURL           = @"https://www.googleapis.com/youtube/v3/subscriptions?part=snippet&maxResults=50&mine=true";
static NSString * const kChannelURL                = @"https://www.googleapis.com/youtube/v3/search?part=snippet&type=channel&maxResults=50&channelId=UCX1DpoQkBN4rv5ZfPivA_Wg";
static NSString * const kPlaylistItemChannelURL    = @"https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=UCX1DpoQkBN4rv5ZfPivA_Wg&key={YOUR_API_KEY}"; // danh sach cac playlist in 1 channel

static NSString *const DEFAULT_KEYWORD = @"starcraftatvapp";

typedef enum {
    SEARCH,
    ACTIVITI,
    HISTORY,
    CHANNEL,
    FAVORITE,
    WATCHLATER,
    LIKED,
    MYVIDEO,
    PLAYLISTITEM,
    VIDEO
} URLType;

@interface YoutubeSearchContants : NSObject

@end
