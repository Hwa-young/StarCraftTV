//
//  Video.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 23..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
@property(weak,nonatomic) NSString* videoName;
@property(weak,nonatomic) NSString* videoImg;
@property(strong,nonatomic) NSString* videoID;
-(NSString*)showAllVideoData;

@end
