//
//  JYOAuthViewController.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/25.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYOAuthViewController.h"
#import "JYHttpTool.h"
#import "JYAccount.h"
#import "MBProgressHUD+MJ.h"
#import "JYAccountTool.h"
#import "UIWindow+Extension.h"
@interface JYOAuthViewController()<UIWebViewDelegate>

@end
@implementation JYOAuthViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc]init];
    webView.delegate = self;
    webView.frame = self.view.bounds;
    webView.scrollView.scrollEnabled = NO;
    NSURL *url = [NSURL URLWithString:JYGetUserAuthorize];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}
#pragma mark - webView代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中..."];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD showMessage:@"正在加载中..."];

}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
       // 1.获得url
        NSString *url = request.URL.absoluteString;
        
        // 2.判断是否为回调地址
        NSRange range = [url rangeOfString:@"code="];
        if (range.length != 0) { // 是回调地址
            // 截取code=后面的参数值
            NSInteger fromIndex = range.location + range.length;
            NSString *code = [url substringFromIndex:fromIndex];
            // 利用code换取一个accessToken
            [self accessTokenWithCode:code];
            return NO;
        }
    
    return YES;
}
/**
 *  网络请求，登录
 *
 *  @param code code
 */
-(void)accessTokenWithCode:(NSString *)code{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = JYAppKey;
    params[@"client_secret"] = JYAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = JYRedirectUrl;

    [JYHttpTool postPath:JYgetOAuthUrl parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"登录成功"];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       JYAccount *account =  [JYAccount accountWithDic:dic];
       [JYAccountTool saveAccount:account];
        [[UIApplication sharedApplication].keyWindow switchRootViewController];
        NSLog(@"%@",dic);
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"登录失败"];

    }];
}
















@end
