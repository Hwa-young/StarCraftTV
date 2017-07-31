//
//  SearchItem.h
//  StarCraftTV
//
//  Created by 고화영 on 6/22/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTSearchItem : NSObject

@property (copy, nonatomic) NSArray *items;
@property (copy, nonatomic) NSDictionary *id;
@property (copy, nonatomic) NSString *etag;
@property (copy, nonatomic) NSString *kind;
@property (copy, nonatomic) NSString *nextPageToken;

@end

