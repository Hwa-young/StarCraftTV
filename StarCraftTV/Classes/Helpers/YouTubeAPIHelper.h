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
#import "YTContentDetailsItem.h"

typedef void(^Completion)(BOOL success, NSError *error);

@interface YouTubeAPIHelper : NSObject

@property (nonatomic) URLType urlType;
@property (strong, nonatomic) NSMutableDictionary *paramaters;
@property (strong, nonatomic) YTSearchItem *searchItem;
@property (strong, nonatomic) YTSearchItem *videoItem;
@property (strong, nonatomic) NSMutableArray *resultSearchVideo;
@property (strong, nonatomic) YTSearchItem *searchChannel;
@property (strong, nonatomic) NSString *keySearchOld;
@property (strong, nonatomic) YTPlaylistItem *playlistItem;
@property (strong, nonatomic) NSDictionary *videoInfoItem;

- (id)init;
- (void)getListVideoInChannel:(NSString *)idChannel completion:(Completion)completion;
- (void)getListPlaylistInChannel:(NSString *)idChannel completion:(Completion)completion;
- (void)getListPlaylistItemsInChannel:(NSString *)idChannel atQueryString:(NSString*)str completion:(Completion)completion;
- (void)getListVideoByKeySearch:(NSString *)key completion:(Completion)completion;
- (void)getListVideoByPlayListWithType:(URLType)type completion:(Completion)completion;
- (void)getVideoInfo:(NSString *)videoID completion:(Completion)completion;

@end
