//
//  StarCraftTVContants.h
//  StarCraftTV
//
//  Created by 고화영 on 7/9/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kAPI_KEY                    = @"AIzaSyAanh-c7aGoFdAEAX9Ie6QQXZBVQjpTrGg";

static NSString * const kSearchURL                  = @"https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=50&type=video&videoType=any&regionCode=KR&channelId=UCX1DpoQkBN4rv5ZfPivA_Wg";
static NSString * const kActivitiURL                = @"https://www.googleapis.com/youtube/v3/activities?part=contentDetails%2Csnippet&maxResults=50&channelId=UCX1DpoQkBN4rv5ZfPivA_Wg";
static NSString * const kChannelContentURL          = @"https://www.googleapis.com/youtube/v3/channels?part=contentDetails&mine=true";
static NSString * const kPlaylistItemURL            = @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50";
static NSString * const kSubscriptionURL            = @"https://www.googleapis.com/youtube/v3/subscriptions?part=snippet&maxResults=50&mine=true";
static NSString * const kChannelURL                 = @"https://www.googleapis.com/youtube/v3/search?part=snippet&type=channel&maxResults=50&channelId=UCX1DpoQkBN4rv5ZfPivA_Wg";
static NSString * const kPlaylistItemChannelURL     = @"https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=UCX1DpoQkBN4rv5ZfPivA_Wg&key={YOUR_API_KEY}"; // danh sach cac playlist in 1 channel
static NSString * const kSearchPlaylistURL          = @"https://www.googleapis.com/youtube/v3/search?part=snippet%2Cid&maxResults=50&type=playlist";

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

/*
 강구열,강도경,강동현,강민,강정우,고석현,구성훈,국기봉,고인규,기욤패트리,김경모,김성대,김성현,김경효,김구현,김기현,김대건,김대기,김동건,김동수,김동준,김동진,김동현,김명운,김민철,김민호,김상욱,김윤중,김윤환,김인기,김재춘,김재훈,김정우,김정훈,김준엽,김지성,김태균,김태훈,김택용,김현우,김환중,김준영,나도현,노준규,도재욱,도진광,문성원,민찬기,박대만,박대호,박동수,박문기,박상우,박성균,박성준,박성훈,박수범,박영민,박용욱,박재영,박재혁,박정석,박태민,배병우,베르트랑,변길섭,변성철,변은종,변현제,변형태,빅터마틴,서지수,서태희,성학승,손석희,손주흥,손찬웅,송병구,송병석,신노열,신대근,신동원,신상문,신재욱,신주영,신희범,심소명,안준호,양희수,염보성,오영종,우정호,원선재,유대현,유병준,유준희,윤용태,윤찬희,이경민,이기석,이동준,이병민,이성은,이승석,이승훈,이영한,이영호,이영호,이재현,이정훈,이주영,이재호,이재훈,이정현,이제동,이창훈,이창훈,임성춘,임정현,임정호,임진묵,임채성,임태규,장용석,장윤철,장진남,장진수,전상욱,전태규,정경두,정명훈,정수영,정영재,정영철,정윤종,정종현,조기석,,조병세,조용호,조일장,조재걸,조중혁,진영화,차명환,차재욱,채도준,최연성,최용주,최인규,최지성,최진우,최호선,탁현승,하늘,하재상,한동욱,한승엽,한상봉,허영무,홍진호,황병영
 */

@end
