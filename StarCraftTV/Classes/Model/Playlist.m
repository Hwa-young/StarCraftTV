//
//  Playlist.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 23..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "Playlist.h"

@implementation Playlist
-(NSString*)showPlaylistData{
    return [NSString stringWithFormat:@"the playlist name is %@ the playlist image url is %@ the playlist id is %@",self.playlistName,self.imgURL,self.playListID];
}

@end
