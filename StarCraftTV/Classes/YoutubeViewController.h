//
//  YoutubeViewController.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YoutubeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString* videoID;
@property (strong, nonatomic) NSString* videoThumnailImage;
@property (strong, nonatomic) NSString* playlistId;

@property (weak, nonatomic) IBOutlet UIView             *playerView;
@property (weak, nonatomic) IBOutlet UIImageView        *thumnailImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConstraint;

@property (weak, nonatomic) IBOutlet UITableView        *listTableView;

@property (nonatomic, strong) NSMutableArray *tableItem;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil title:(NSString *)titleString;

@end
