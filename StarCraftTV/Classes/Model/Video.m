//
//  Video.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 23..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "Video.h"

@implementation Video
-(NSString*)showAllVideoData{
    return [NSString stringWithFormat:@"the video name is %@ video image url is %@ video id is %@",_videoName,_videoImg,_videoID];
}


@end
