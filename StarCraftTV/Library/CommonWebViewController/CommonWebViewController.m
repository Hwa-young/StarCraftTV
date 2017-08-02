//
//  CommonWebViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 6. 28..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "CommonWebViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "GAManager.h"

@interface CommonWebViewController ()

@end

@implementation CommonWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:NSLocalizedString(@"NOTICE", @"NOTICE")];
    
    [GAManager trackWithView:NSStringFromClass(self.class)];
    
    _mWebView.delegate = self;
    
//    noticeURL
    [SVProgressHUD show];

    const char* cstr = "https://sites.google.com/view/starcrafttv/home/notice";
    NSString* str = [NSString stringWithUTF8String:cstr];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    [_mWebView loadRequest:req];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
}

@end
