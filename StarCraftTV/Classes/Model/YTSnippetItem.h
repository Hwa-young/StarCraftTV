//
//  SnippetItem.h
//  StarCraftTV
//
//  Created by 고화영 on 6/28/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTSnippetItem : NSObject

@property (copy, nonatomic) NSString *channelId;
//@property (copy, nonatomic) NSString *description;
@property (copy, nonatomic) NSString *publishedAt;
@property (copy, nonatomic) NSDictionary *thumbnails;
@property (copy, nonatomic) NSDictionary *resourceId; // get channel id
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *videoId;
@property (copy, nonatomic) NSString *type;

@end
