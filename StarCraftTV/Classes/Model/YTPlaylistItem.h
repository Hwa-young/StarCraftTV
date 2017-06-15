//
//  YTPlaylistItem.h
//  StarCraftTV
//
//  Created by 고화영 on 7/10/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTPlaylistItem : NSObject
@property (copy, nonatomic) NSString *likeId;
@property (copy, nonatomic) NSString *favoritesId;
@property (copy, nonatomic) NSString *uploadsId;
@property (copy, nonatomic) NSString *watchHistoryId;
@property (copy, nonatomic) NSString *watchLaterId;
@end
