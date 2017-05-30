//
//  Playlist.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 23..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Playlist : NSObject
@property(strong,nonatomic) NSString * playlistName;
@property(strong,nonatomic) NSString* imgURL;
@property(strong,nonatomic) NSString* playListID;
-(NSString*)showPlaylistData;
@end
