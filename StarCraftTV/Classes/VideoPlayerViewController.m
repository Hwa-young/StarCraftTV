//
//  VideoPlayerViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "VideoPlayerViewController.h"

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *videoId =_videoID;
    
    
//    NSDictionary *playerVars = @{
//                                 @"controls" : @0,
//                                 @"playsinline" : @1,
//                                 @"autohide" : @1,
//                                 @"showinfo" : @0,
//                                 @"modestbranding" : @1,
//                                 @"origin" :@"http://www.youtube.com"
//                                 };
//    self.playerView.delegate = self;
//    [self.playerView loadWithVideoId:videoId playerVars:playerVars];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedPlaybackStartedNotification:)
                                                 name:@"Playback started"
                                               object:nil];
}

/*
- (void)playerView:(YTPlayerView *)ytPlayerView didChangeToState:(YTPlayerState)state {
   // NSString *message = [NSString stringWithFormat:@"Player state changed: %ld\n", (long)state];
    
}

- (void)playerView:(YTPlayerView *)playerView didPlayTime:(float)playTime {
    float progress = playTime/self.playerView.duration;
    [self.slider setValue:progress];
}

- (IBAction)onSliderChange:(id)sender {
    float seekToTime = self.playerView.duration * self.slider.value;
    [self.playerView seekToSeconds:seekToTime allowSeekAhead:YES];
}

- (IBAction)buttonPressed:(id)sender {
    if (sender == self.playButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Playback started" object:self];
        [self.playerView playVideo];
    } else if (sender == self.stopButton) {
        [self.playerView stopVideo];
    } else if (sender == self.pauseButton) {
        [self.playerView pauseVideo];
    } else if (sender == self.reverseButton) {
        float seekToTime = self.playerView.currentTime - 30.0;
        [self.playerView seekToSeconds:seekToTime allowSeekAhead:YES];
        
    } else if (sender == self.forwardButton) {
        float seekToTime = self.playerView.currentTime + 30.0;
        [self.playerView seekToSeconds:seekToTime allowSeekAhead:YES];
        
    } else if (sender == self.startButton) {
        [self.playerView seekToSeconds:0 allowSeekAhead:YES];
        
    }
}

- (void)receivedPlaybackStartedNotification:(NSNotification *) notification {
    if([notification.name isEqual:@"Playback started"] && notification.object != self) {
        [self.playerView pauseVideo];
    }
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
