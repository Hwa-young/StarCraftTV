//
//  UIView+Additions.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIView (Additions)

@property (nonatomic, strong) NSString *tagString;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint topLeft;
@property (nonatomic, assign) CGPoint topRight;
@property (nonatomic, assign) CGPoint bottomLeft;
@property (nonatomic, assign) CGPoint bottomRight;

- (id)initWithNibName:(NSString *)nibNameOrNil;

- (CGFloat)boundsWidth;

- (CGFloat)boundsHeight;

- (CGPoint)boundsCenter;

- (UIView *)viewWithTagString:(NSString *)value;

- (UIView *)viewWithTagPath:(NSString *)value;

- (UIView *)viewAtPath:(NSString *)name;

- (UIView *)subview:(NSString *)name;

- (UIView *)subviewForClass:(Class)viewClass;

- (UIView *)prevSibling;

- (UIView *)nextSibling;

- (void)removeAllSubviews;

- (UIViewController *)viewController;

- (void)hideKeyboardForStatement:(UIView *)view;

- (void)hideKeyboard;


@property (readwrite, nonatomic, copy) void (^tapHandler)(UIGestureRecognizer *sender);

- (void)initialiseTapHandler:(void (^) (UIGestureRecognizer *sender))block forTaps:(int)numberOfTaps;

- (IBAction)handleTap:(UIGestureRecognizer *)sender;

@end
