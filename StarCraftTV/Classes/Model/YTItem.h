//
//  Item.h
//  StarCraftTV
//
//  Created by 고화영 on 6/28/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTSnippetItem.h"

@interface YTItem : NSObject

@property (copy, nonatomic) NSString *etag;
@property (copy, nonatomic) NSDictionary *id;
@property (copy, nonatomic) NSDictionary *contentDetails;
@property (copy, nonatomic) NSString *kind;

@property (strong, nonatomic) YTSnippetItem *snippet;

@end
