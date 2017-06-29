//
//  CommonWebViewController.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 6. 28..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonWebViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mWebView;

@end
