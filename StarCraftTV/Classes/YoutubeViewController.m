//
//  YoutubeViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "YoutubeViewController.h"

@interface YoutubeViewController ()

@end

@implementation YoutubeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
         {
             self.heightConstraint.constant = [[UIScreen mainScreen] applicationFrame].size.height;
             self.topHeightConstraint.constant = 0.f;
             [self.navigationController setNavigationBarHidden:YES];
             [self.navigationController setToolbarHidden:YES];
             
         }
         if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
         {
             self.heightConstraint.constant = 211.f;// 디바이스 사이즈별로 변경하자.
             self.topHeightConstraint.constant = 64.f;
             [self.navigationController setNavigationBarHidden:NO];
             [self.navigationController setToolbarHidden:NO];
         }
     }
                                 completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
                                 }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
