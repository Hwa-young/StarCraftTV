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
#import "ActivitiItem.h"

@interface YouTubeAPIHelper()

@property (strong, nonatomic) NSURL *url;

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
        self.paramaters[@"key"] = kAPI_KEY;
    }
    return self;
}

- (void)settingAccessToken:(NSString *)accessToken {
    
    self.accessToken = accessToken;
    [self settingURL];
    
}
- (void)settingURL {
    
//    self.paramaters[@"key"] = kAPI_KEY;
    
//    if ([self.accessToken isEqualToString:@""]) {
//        if ([self.paramaters objectForKey:@"key"])
//            self.paramaters[@"key"] = kAPI_KEY;
//        else
//            [self.paramaters setObject:kAPI_KEY forKey:@"key"];
//        
//        if ([self.paramaters objectForKey:@"access_token"])
//            [self.paramaters removeObjectForKey:@"access_token"];
//
//    }
//    else {
//        if ([self.paramaters objectForKey:@"access_token"])
//            self.paramaters[@"access_token"] = self.accessToken;
//        else
//            [self.paramaters setObject:self.accessToken forKey:@"access_token"];
//        
//        if ([self.paramaters objectForKey:@"key"])
//            [self.paramaters removeObjectForKey:@"key"];
//    }
//
//    if ([self.paramaters objectForKey:@"pageToken"])
//        self.paramaters[@"pageToken"] = (self.searchItem.nextPageToken == nil ? @"" : self.searchItem.nextPageToken);
//    else
//        [self.paramaters setObject:(self.searchItem.nextPageToken == nil ? @"" : self.searchItem.nextPageToken) forKey:@"pageToken"];

}

- (void)getObjectWith:(URLType)typeURL completion:(Completion)completion {
    
    NSLog(@"Call Youtube API URL : %@", self.url.absoluteString);
    NSLog(@"Call Youtube API Params : %@", self.paramaters);
    
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
                                 @"items" : @"YTItem"
//                                 @"playlistId": @"items[0].id.playlistId"
                                 };
                    }];
                    
                    self.searchItem = [YTSearchItem mj_objectWithKeyValues:responseObject];
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

- (void)getListPlaylistInChannel:(NSString *)idChannel completion:(Completion)completion {
    
    self.url = [NSURL URLWithString:kSearchPlaylistURL];
    
    if ([self.paramaters objectForKey:@"channelId"])
        self.paramaters[@"channelId"] = idChannel;
    else
        [self.paramaters setObject:idChannel forKey:@"channelId"];
    
//    if (![self.keySearchOld isEqualToString:idChannel]) {
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
    
    [self getObjectWith:PLAYLISTITEM completion:completion];
}


- (void)getListPlaylistItemsInChannel:(NSString *)idChannel atQueryString:(NSString*)str completion:(Completion)completion {
    
    self.url = [NSURL URLWithString:kSearchPlaylistItemsURL];
    
    if ([self.paramaters objectForKey:@"q"])
        self.paramaters[@"q"] = str;
    else
        [self.paramaters setObject:str forKey:@"q"];
    
    if ([self.paramaters objectForKey:@"channelId"])
        self.paramaters[@"channelId"] = idChannel;
    else
        [self.paramaters setObject:idChannel forKey:@"channelId"];
    
    //    if (![self.keySearchOld isEqualToString:idChannel]) {
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
    
//    if ([self.paramaters objectForKey:@"playlistId"])
//        self.paramaters[@"playlistId"] = self.playlistItem.likeId;
//    else
//        [self.paramaters setObject:self.playlistItem.likeId forKey:@"playlistId"];

//    switch (type) {
//        case HISTORY:
//            [self.paramaters setValue:self.playlistItem.watchHistoryId forKey:@"playlistId"];
//            break;
//        case LIKED:
//            [self.paramaters setValue:self.playlistItem.likeId forKey:@"playlistId"];
//            break;
//        case MYVIDEO:
//            [self.paramaters setValue:self.playlistItem.uploadsId forKey:@"playlistId"];
//            break;
//        case FAVORITE:
//            [self.paramaters setValue:self.playlistItem.favoritesId forKey:@"playlistId"];
//            break;
//        case WATCHLATER:
//            [self.paramaters setValue:self.playlistItem.watchLaterId forKey:@"playlistId"];
//            break;
//        default:
//            break;
//    }
//    https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&key=AIzaSyAanh-c7aGoFdAEAX9Ie6QQXZBVQjpTrGg&pageToken=,
//    https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50
//    https://www.googleapis.com/youtube/v3/playlistItems?part=id,snippet,contentDetails,status&maxResults=50&playlistId=%@&key=%@
    
    [self getObjectWith:VIDEO completion:completion];
}

@end
