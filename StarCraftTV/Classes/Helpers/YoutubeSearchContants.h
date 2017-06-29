//
//  StarCraftTVContants.h
//  StarCraftTV
//
//  Created by 고화영 on 7/9/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kAPI_KEY                    = @"AIzaSyAanh-c7aGoFdAEAX9Ie6QQXZBVQjpTrGg";

static NSString * const kSearchURL                  = @"https://www.googleapis.com/youtube/v3/search?part=snippet,id&maxResults=50&type=video&videoType=any&regionCode=KR&channelId=UCX1DpoQkBN4rv5ZfPivA_Wg&order=date";
static NSString * const kPlaylistItemURL            = @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50";
static NSString * const kChannelURL                 = @"https://www.googleapis.com/youtube/v3/search?part=snippet&type=channel&maxResults=50&channelId=UCX1DpoQkBN4rv5ZfPivA_Wg";
static NSString * const kSearchPlaylistURL          = @"https://www.googleapis.com/youtube/v3/search?part=snippet&type=playlist&maxResults=50";
static NSString * const kSearchPlaylistItemsURL     = @"https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&order=relevance&maxResults=50";

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
