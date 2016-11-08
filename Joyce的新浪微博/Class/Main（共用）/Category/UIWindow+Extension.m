//
//  UIWindow+Extension.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/5.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "JYMainTabBarController.h"
#import "JYUserGuideViewController.h"
@implementation UIWindow (Extension)
-(void)switchRootViewController{
    
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    //获取info.plist文件
    NSDictionary *dic = [[NSBundle mainBundle]infoDictionary];
    //获取版本号
    NSString *newVersion = dic[key];
    if ([lastVersion isEqualToString:newVersion]) {
        self.rootViewController = [[JYMainTabBarController alloc]init];
        
    }else{
        self.rootViewController = [[JYMainTabBarController alloc]init];
        [[NSUserDefaults standardUserDefaults]setObject:newVersion forKey:key];
        
    }

}
@end
