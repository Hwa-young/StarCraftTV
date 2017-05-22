//
//  UIAlertView+Additions.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VoidBlock)();
typedef void (^DismissBlock)(int buttonIndex);
typedef void (^CancelBlock)();


@interface UIAlertView (Additions)

@property (copy, nonatomic) DismissBlock dismissBlock;
@property (copy, nonatomic) CancelBlock cancelBlock;

+ (UIAlertView *)alertViewWithMessage:(NSString *)message;

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
							message:(NSString *)message;

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
							message:(NSString *)message
				  cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
							message:(NSString *)message
				  cancelButtonTitle:(NSString *)cancelButtonTitle
				  otherButtonTitles:(NSArray *)otherButtons
						  onDismiss:(DismissBlock)dismissed
						   onCancel:(CancelBlock)cancelled;

@end
