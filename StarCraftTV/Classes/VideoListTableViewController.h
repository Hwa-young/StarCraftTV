//
//  VideoListTableViewController.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 6. 14..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoListTableViewController : UITableViewController

- (instancetype)initWithFilterHeader:(BOOL)flag;

@property (nonatomic, strong) NSMutableArray    *tableItem;
@property (nonatomic, strong) NSString          *playListID;
@property (nonatomic, strong) NSString          *queryString;

@property (nonatomic, assign) BOOL              needFilterFlag;

@end
