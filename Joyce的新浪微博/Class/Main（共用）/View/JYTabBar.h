//
//  JYTabBar.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/23.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JYTabBar;
@protocol JYTabBarDelegate <NSObject,UITabBarDelegate>
@optional
-(void)tabBarDidClicktarBarBtn:(JYTabBar *)tabBar;

@end

@interface JYTabBar : UITabBar

@property(nonatomic,weak) id<JYTabBarDelegate>delegate;

@end
