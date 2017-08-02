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
#import "YTContentDetailsItem.h"

@interface YouTubeAPIHelper()

@property (strong, nonatomic) NSURL *url;

@end

@implementation YouTubeAPIHelper

- (id)init
{
    self = [super init];
    if (self) {
        self.paramaters = [NSMutableDictionary new];
        self.keySearchOld = @"";
        self.searchItem = [YTSearchItem new];
        self.resultSearchVideo = [NSMutableArray new];
        self.searchChannel = [YTSearchItem new];
        self.videoInfoItem = [NSMutableDictionary new];
        self.statisticsItem = [NSMutableDictionary new];
        self.videoItem = [YTSearchItem new];
        self.paramaters[@"key"] = kAPI_KEY;
    }
    return self;
}

- (void)getObjectWith:(URLType)typeURL completion:(Completion)completion
{
    AFHTTPSessionManager *managerSession = [AFHTTPSessionManager manager];
    [managerSession GET:self.url.absoluteString
             parameters:self.paramaters
               progress:nil
                success:^(NSURLSessionTask *task, id responseObject) {
        if (responseObject) {
            switch (typeURL) {
                    
                case PLAYLISTITEM:
                    self.searchItem = [YTSearchItem mj_objectWithKeyValues:responseObject];
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
                    self.searchItem  = [YTSearchItem mj_objectWithKeyValues:responseObject];
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
                    self.searchChannel  = [YTSearchItem mj_objectWithKeyValues:responseObject];
                    break;
                    
                case VIDEOINFO:
                    self.videoItem  = [YTSearchItem mj_objectWithKeyValues:responseObject];
                    self.videoInfoItem  = [[[YTPlaylistItem mj_objectWithKeyValues:responseObject] items] objectAtIndex:0][@"contentDetails"];
                    self.statisticsItem  = [[[YTPlaylistItem mj_objectWithKeyValues:responseObject] items] objectAtIndex:0][@"statistics"];
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

- (void)getDictionnary:(void(^)(id response, NSError * error))completion
{
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

- (void)getListVideoInChannel:(NSString *)idChannel completion:(Completion)completion
{
    
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

- (void)getListPlaylistInChannel:(NSString *)idChannel completion:(Completion)completion
{
    self.url = [NSURL URLWithString:kSearchPlaylistURL];
    
    if ([self.paramaters objectForKey:@"channelId"])
        self.paramaters[@"channelId"] = idChannel;
    else
        [self.paramaters setObject:idChannel forKey:@"channelId"];

    [self getObjectWith:PLAYLISTITEM completion:completion];
}

- (void)getListPlaylistItemsInChannel:(NSString *)idChannel atQueryString:(NSString*)str completion:(Completion)completion
{    
    self.url = [NSURL URLWithString:kSearchPlaylistItemsURL];
    
    if ([self.paramaters objectForKey:@"q"])
        self.paramaters[@"q"] = str;
    else
        [self.paramaters setObject:str forKey:@"q"];
    
    if ([self.paramaters objectForKey:@"channelId"])
        self.paramaters[@"channelId"] = idChannel;
    else
        [self.paramaters setObject:idChannel forKey:@"channelId"];

    [self getObjectWith:VIDEO completion:completion];
}

- (void)getListVideoByKeySearch:(NSString *)key completion:(Completion)completion
{
    self.url = [NSURL URLWithString:kSearchURL];
    self.urlType = SEARCH;
    
    if ([self.paramaters objectForKey:@"q"])
        self.paramaters[@"q"] = key;
    else
        [self.paramaters setObject:key forKey:@"q"];

    self.keySearchOld = key;
    [self getObjectWith:VIDEO completion:completion];
}

- (void)getListVideoByPlayListWithType:(URLType)type completion:(Completion)completion
{
    self.url = [NSURL URLWithString:kPlaylistItemURL];

    [self getObjectWith:VIDEO completion:completion];
}

- (void)getVideoInfo:(NSString *)videoID completion:(Completion)completion
{
    self.url = [NSURL URLWithString:kVideoInfoItemsURL];
    
    if ([self.paramaters objectForKey:@"videoId"])
        self.paramaters[@"id"] = videoID;
    else
        [self.paramaters setObject:videoID forKey:@"id"];
    
    [self getObjectWith:VIDEOINFO completion:completion];
}

@end
