//
//  UIAlertView+Additions.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 22..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "UIAlertView+Additions.h"
#import <objc/runtime.h>

static char DISMISS_IDENTIFIER;
static char CANCEL_IDENTIFIER;

@implementation UIAlertView (Additions)
@dynamic dismissBlock, cancelBlock;

- (DismissBlock)dismissBlock
{
	return objc_getAssociatedObject(self, &DISMISS_IDENTIFIER);
}

- (void)setDismissBlock:(DismissBlock)dismissBlock
{
	objc_setAssociatedObject(self, &DISMISS_IDENTIFIER, dismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CancelBlock)cancelBlock
{
	return objc_getAssociatedObject(self, &CANCEL_IDENTIFIER);
}

- (void)setCancelBlock:(CancelBlock)cancelBlock
{
	objc_setAssociatedObject(self, &CANCEL_IDENTIFIER, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (UIAlertView *)alertViewWithMessage:(NSString *)message
{
	return [UIAlertView alertViewWithTitle:nil
								   message:message
						 cancelButtonTitle:NSLocalizedString(@"확인", @"")];
}

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
							message:(NSString *)message {
	return [UIAlertView alertViewWithTitle:title
								   message:message
						 cancelButtonTitle:NSLocalizedString(@"확인", @"")];
}

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
							message:(NSString *)message
				  cancelButtonTitle:(NSString *)cancelButtonTitle {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:nil
										  cancelButtonTitle:cancelButtonTitle
										  otherButtonTitles:nil];
	[alert show];
	return alert;
}

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
							message:(NSString *)message
				  cancelButtonTitle:(NSString *)cancelButtonTitle
				  otherButtonTitles:(NSArray *)otherButtons
						  onDismiss:(DismissBlock)dismissed
						   onCancel:(CancelBlock)cancelled {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    [alert setDismissBlock:dismissed];
    [alert setCancelBlock:cancelled];
    
    for (NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
    return alert;
}

+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == [alertView cancelButtonIndex]) {
		if (alertView.cancelBlock) {
            alertView.cancelBlock();
        }
	} else {
        if (alertView.dismissBlock) {
            alertView.dismissBlock((int)buttonIndex - 1);
        }
    }
}

@end
