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


#define noticeURL @"https://sites.google.com/view/starcrafttv/홈/공지사항"

@interface CommonWebViewController ()

@end

@implementation CommonWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"공지사항"];
    
    [GAManager trackWithView:NSStringFromClass(self.class)];
    
    _mWebView.delegate = self;
    
//    noticeURL
    [SVProgressHUD show];

    const char* cstr = "https://sites.google.com/view/starcrafttv/%ED%99%88/%EA%B3%B5%EC%A7%80%EC%82%AC%ED%95%AD";
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
