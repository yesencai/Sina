//
//  AppDelegate.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/16.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYAppDelegate.h"
#import "JYUserGuideViewController.h"
#import "JYMainTabBarController.h"
#import "JYOAuthViewController.h"
#import "JYAccount.h"
#import "JYAccountTool.h"
#import "UIWindow+Extension.h"
#import "SDWebImageManager.h"
@interface JYAppDelegate ()

@end

@implementation JYAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    JYAccount *account = [JYAccountTool account];
    if (account){
        [self.window switchRootViewController];
    }else{
        
        //设置根试图控制器
        self.window.rootViewController = [[JYOAuthViewController alloc]init];
    }
    //显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        
       [application endBackgroundTask:task];
    } ];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    SDWebImageManager *manage = [SDWebImageManager sharedManager];
    //取消下载
    [manage cancelAll];
    //清楚缓存
    [manage.imageCache clearMemory];
}
@end
