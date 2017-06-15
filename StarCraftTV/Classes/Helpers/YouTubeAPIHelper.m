//
//  YouTubeAPIHelper.m
//  StarCraftTV
//
//  Created by 고화영 on 7/10/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//



#import "YouTubeAPIHelper.h"
#import "AFHTTPSessionManager.h"
#import "MJExtension.h"
#import "YTSearchItem.h"
#import "YTItem.h"
#import "YTPlaylistItem.h"
#import "ActivitiItem.h"

@interface YouTubeAPIHelper()

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) YTPlaylistItem *playlistItem;

@end

@implementation YouTubeAPIHelper

- (id)init {
    self = [super init];
    if (self) {
        self.urlType = SEARCH;
        self.paramaters = [NSMutableDictionary new];
        self.accessToken = @"";
        self.keySearchOld = @"";
        self.url = [NSURL URLWithString:kSearchURL];
        self.searchItem = [YTSearchItem new];
        self.resultSearchVideo = [NSMutableArray new];
        self.searchChannel = [YTSearchItem new];
    }
    return self;
}

- (void)settingAccessToken:(NSString *)accessToken {
    
    self.accessToken = accessToken;
    [self settingURL];
    
}
- (void)settingURL {
    
    if ([self.accessToken isEqualToString:@""]) {
        if ([self.paramaters objectForKey:@"key"])
            self.paramaters[@"key"] = kAPI_KEY;
        else
            [self.paramaters setObject:kAPI_KEY forKey:@"key"];
        
        if ([self.paramaters objectForKey:@"access_token"])
            [self.paramaters removeObjectForKey:@"access_token"];

    }
    else {
        if ([self.paramaters objectForKey:@"access_token"])
            self.paramaters[@"access_token"] = self.accessToken;
        else
            [self.paramaters setObject:self.accessToken forKey:@"access_token"];
        
        if ([self.paramaters objectForKey:@"key"])
            [self.paramaters removeObjectForKey:@"key"];
    }

    if ([self.paramaters objectForKey:@"pageToken"])
        self.paramaters[@"pageToken"] = (self.searchItem.nextPageToken == nil ? @"" : self.searchItem.nextPageToken);
    else
        [self.paramaters setObject:(self.searchItem.nextPageToken == nil ? @"" : self.searchItem.nextPageToken) forKey:@"pageToken"];

}

- (void)getObjectWith:(URLType)typeURL completion:(Completion)completion {
    
    AFHTTPSessionManager *managerSession = [AFHTTPSessionManager manager];
    [managerSession GET:self.url.absoluteString
             parameters:self.paramaters
               progress:nil
                success:^(NSURLSessionTask *task, id responseObject) {
        if (responseObject) {
            switch (typeURL) {
                case PLAYLISTITEM:
                    [YTPlaylistItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                        return @{
                                 @"likeId" : @"items[0].contentDetails.relatedPlaylists.likes",
                                 @"favoritesId": @"items[0].contentDetails.relatedPlaylists.favorites",
                                 @"uploadsId": @"items[0].contentDetails.relatedPlaylists.uploads",
                                 @"watchHistoryId": @"items[0].contentDetails.relatedPlaylists.watchHistory",
                                 @"watchLaterId": @"items[0].contentDetails.relatedPlaylists.watchLater"
                                 };
                    }];
                    
                    self.playlistItem = [YTPlaylistItem mj_objectWithKeyValues:responseObject];
                    NSLog(@" %@", responseObject);
                    break;
                case VIDEO:
                    
                    [YTItem mj_setupObjectClassInArray: ^NSDictionary *{
                        return @{
                                 @"items.snippet" : @"YTSnippetItem",
                                 };
                    }];
                    
                    [YTSearchItem mj_setupObjectClassInArray: ^NSDictionary *{
                        return @{
                                 @"items" : @"YTItem"
                                 };
                    }];
                    
                    NSLog(@" %@", responseObject);
                    self.searchItem  = [YTSearchItem mj_objectWithKeyValues:responseObject];
                    
                    //neu la activity
                    if (self.urlType == ACTIVITI) {
                    for(YTItem *info in self.searchItem.items) {
                        if ([info.snippet.type isEqualToString:@"upload"]) {
                            YTItem *temp = info;
                            temp.snippet.videoId = info.contentDetails[@"upload"][@"videoId"];
                            [self.resultSearchVideo addObject:temp];
                        } else if ([info.snippet.type isEqualToString:@"like"]) {
                            YTItem *temp = info;
                            temp.snippet.videoId = info.contentDetails[@"like"][@"resourceId"][@"videoId"];
                            [self.resultSearchVideo addObject:temp];
                        }
                    }
                    }
                    
                    break;
                case CHANNEL:
                    [YTItem mj_setupObjectClassInArray: ^NSDictionary *{
                        return @{
                                 @"items.snippet" : @"YTSnippetItem"
                                 };
                    }];
                    
                    [YTSearchItem mj_setupObjectClassInArray: ^NSDictionary *{
                        return @{
                                 @"items" : @"YTItem"
                                 };
                    }];
                    
                    NSLog(@" %@", responseObject);
                    self.searchChannel  = [YTSearchItem mj_objectWithKeyValues:responseObject];
                    break;

                default:
                    break;
            }
           
            completion(YES, nil);
        }
    }
                failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    completion(NO, error);
                }];

}

- (void)getDictionnary:(void(^)(id response, NSError * error))completion {
    
    AFHTTPSessionManager *managerSession = [AFHTTPSessionManager manager];
    [managerSession GET:self.url.absoluteString
             parameters:self.paramaters
               progress:nil
                success:^(NSURLSessionTask *task, id responseObject) {
                    if (responseObject) {
                        NSLog(@" %@", responseObject);
                        completion(responseObject, nil);
                    }
                }
                failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    completion(nil, error);
                }];
    
}

- (void)getListVideoActivitied:(Completion)completion {
    
    self.url = [NSURL URLWithString:kActivitiURL];
    self.urlType = ACTIVITI;
    
    if ([self.paramaters objectForKey:@"q"])
        [self.paramaters removeObjectForKey:@"q"];
    
//    if (self.searchItem.nextPageToken == nil) {
//        if ([self.paramaters objectForKey:@"pageToken"])
//            self.paramaters[@"pageToken"] = @"";
//        else
//            [self.paramaters setObject:@"" forKey:@"pageToken"];
//    }
//    else {
//        if ([self.paramaters objectForKey:@"pageToken"])
//            self.paramaters[@"pageToken"] = self.searchItem.nextPageToken;
//        else
//            [self.paramaters setObject:self.searchItem.nextPageToken forKey:@"pageToken"];
//    }
    
    [self getObjectWith:VIDEO completion:completion];
}

- (void)getListVideoInChannel:(NSString *)idChannel completion:(Completion)completion {
    
    self.url = [NSURL URLWithString:kSearchURL];
    
    if ([self.paramaters objectForKey:@"channelId"])
        self.paramaters[@"channelId"] = idChannel;
    else
        [self.paramaters setObject:idChannel forKey:@"channelId"];
    
    if (![self.keySearchOld isEqualToString:idChannel]) {
        if ([self.paramaters objectForKey:@"pageToken"])
            self.paramaters[@"pageToken"] = @"";
        else
            [self.paramaters setObject:@"" forKey:@"pageToken"];
    }
    else {
        if ([self.paramaters objectForKey:@"pageToken"])
            self.paramaters[@"pageToken"] = self.searchItem.nextPageToken;
        else
            [self.paramaters setObject:self.searchItem.nextPageToken forKey:@"pageToken"];
    }
    
    [self getObjectWith:VIDEO completion:completion];
}

- (void)getListVideoByKeySearch:(NSString *)key completion:(Completion)completion {
    
    self.url = [NSURL URLWithString:kSearchURL];
    self.urlType = SEARCH;
    
    if ([self.paramaters objectForKey:@"q"])
        self.paramaters[@"q"] = key;
    else
        [self.paramaters setObject:key forKey:@"q"];
    
//    if (![self.keySearchOld isEqualToString:key]) {
//        if ([self.paramaters objectForKey:@"pageToken"])
//            self.paramaters[@"pageToken"] = @"";
//        else
//            [self.paramaters setObject:@"" forKey:@"pageToken"];
//    }
//    else {
//        if ([self.paramaters objectForKey:@"pageToken"])
//            self.paramaters[@"pageToken"] = self.searchItem.nextPageToken;
//        else
//            [self.paramaters setObject:self.searchItem.nextPageToken forKey:@"pageToken"];
//    }

    self.keySearchOld = key;
    [self getObjectWith:VIDEO completion:completion];
}

- (void)getListVideoByPlayListWithType:(URLType)type completion:(Completion)completion {
    
    self.url = [NSURL URLWithString:kPlaylistItemURL];
    
    if ([self.paramaters objectForKey:@"playlistId"])
        self.paramaters[@"playlistId"] = self.playlistItem.likeId;
    else
        [self.paramaters setObject:self.playlistItem.likeId forKey:@"playlistId"];

    switch (type) {
        case HISTORY:
            [self.paramaters setValue:self.playlistItem.watchHistoryId forKey:@"playlistId"];
            break;
        case LIKED:
            [self.paramaters setValue:self.playlistItem.likeId forKey:@"playlistId"];
            break;
        case MYVIDEO:
            [self.paramaters setValue:self.playlistItem.uploadsId forKey:@"playlistId"];
            break;
        case FAVORITE:
            [self.paramaters setValue:self.playlistItem.favoritesId forKey:@"playlistId"];
            break;
        case WATCHLATER:
            [self.paramaters setValue:self.playlistItem.watchLaterId forKey:@"playlistId"];
            break;
        default:
            break;
    }
    
    [self getObjectWith:VIDEO completion:completion];
}

- (void)getMyPlaylistItems {
    
    self.url = [NSURL URLWithString:kChannelContentURL];
    
    [self getObjectWith:PLAYLISTITEM completion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"Get playlist history: %@", self.playlistItem.watchHistoryId);
            NSLog(@"Get playlist like: %@", self.playlistItem.likeId);
            NSLog(@"Get playlist favorit: %@", self.playlistItem.favoritesId);
            NSLog(@"Get playlist watch later: %@", self.playlistItem.watchLaterId);
            NSLog(@"Get playlist uploads video: %@", self.playlistItem.uploadsId);
        }
        else
            NSLog(@"Error : %@", error);
    }];
}

- (void)getMySubscriptions:(void(^)(BOOL success, NSError *error))completion {
    
    self.url = [NSURL URLWithString:kSubscriptionURL];
    
    [self getObjectWith:CHANNEL completion:completion];
}

- (void)getChannelActivities:(void(^)(BOOL success, NSError *error))completion {
    
    self.url = [NSURL URLWithString:kChannelURL];
    
    [self getObjectWith:CHANNEL completion:completion];
}

//- (void)getImageForVideo:(void(^)(BOOL success, NSError *error))completion {
//   
//}
@end