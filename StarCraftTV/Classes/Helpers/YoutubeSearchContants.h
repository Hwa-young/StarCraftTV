//
//  StarCraftTVContants.h
//  StarCraftTV
//
//  Created by 고화영 on 7/9/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kAPI_KEY                    = @"AIzaSyAanh-c7aGoFdAEAX9Ie6QQXZBVQjpTrGg";

static NSString * const kSearchURL                  = @"https://www.googleapis.com/youtube/v3/search?part=snippet,id&maxResults=50&type=video&videoType=any&regionCode=KR&q=starcrafttvapp&order=relevance";

static NSString * const kPlaylistItemURL            = @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50";
static NSString * const kChannelURL                 = @"https://www.googleapis.com/youtube/v3/search?part=snippet&type=channel&maxResults=50&channelId=UCX1DpoQkBN4rv5ZfPivA_Wg";
static NSString * const kSearchPlaylistURL          = @"https://www.googleapis.com/youtube/v3/search?part=snippet&type=playlist&maxResults=50";
static NSString * const kSearchPlaylistItemsURL     = @"https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&order=relevance&maxResults=50";
static NSString * const kVideoInfoItemsURL          = @"https://www.googleapis.com/youtube/v3/videos?part=contentDetails,snippet,statistics";

static NSString * const kUser1 = @"";
static NSString * const kUser2 = @"";
static NSString * const kUser3 = @"";
static NSString * const kUser4 = @"";

static NSString * const kChannelID1 = @"UCX1DpoQkBN4rv5ZfPivA_Wg";  // 일반
static NSString * const kChannelID2 = @"UCi0IFv8X6tJ6gS5eDqlYqcg";  // 06~07
static NSString * const kChannelID3 = @"UCCM3BAZzpl_3rkHhMhOLrFg";  // 04~05
static NSString * const kChannelID4 = @"UCTIIyJUVWVRNc0TyG7gqoAQ";  // 02~03

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
    VIDEO,
    VIDEOINFO
} URLType;

@interface YoutubeSearchContants : NSObject

@end
