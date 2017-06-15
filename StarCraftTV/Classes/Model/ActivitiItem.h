//
//  ActivitiItem.h
//  StarCraftTV
//
//  Created by 고화영 on 7/13/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTSnippetItem.h"

@interface ActivitiItem : NSObject
@property (copy, nonatomic) NSString *etag;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *kind;
@property (strong, nonatomic) YTSnippetItem *snippet;
@end
