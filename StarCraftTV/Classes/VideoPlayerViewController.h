//
//  VideoPlayerViewController.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *playerView;

@property(nonatomic, weak) IBOutlet UIButton *playButton;
@property(nonatomic, weak) IBOutlet UIButton *pauseButton;
@property(nonatomic, weak) IBOutlet UIButton *stopButton;
@property(nonatomic, weak) IBOutlet UIButton *startButton;
@property(nonatomic, weak) IBOutlet UIButton *reverseButton;
@property(nonatomic, weak) IBOutlet UIButton *forwardButton;


@property(nonatomic, weak) IBOutlet UISlider *slider;

- (IBAction)onSliderChange:(id)sender;

- (IBAction)buttonPressed:(id)sender;

@property(nonatomic,strong) NSString* videoID;

@end
