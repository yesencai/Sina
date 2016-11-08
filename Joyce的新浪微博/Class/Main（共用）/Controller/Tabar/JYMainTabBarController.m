//
//  JYMainTabBarController.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/16.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYMainTabBarController.h"
#import "JYDefine.h"
#import "JYHomeViewController.h"
#import "JYMessageViewController.h"
#import "JYDiscoveryViewController.h"
#import "JYMeViewController.h"
#import "JYNavigationController.h"
#import "JYTabBar.h"
#import "JYCenterAddView.h"
#import "JYSendStatusViewController.h"
@interface JYMainTabBarController()<JYTabBarDelegate,JYCenterAddViewDelegate>
@property(nonatomic,strong)JYCenterAddView *addView;

@end
@implementation JYMainTabBarController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    JYHomeViewController *home = [[JYHomeViewController alloc]init];
    [self addTabBarWithVC:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    JYMessageViewController *message = [[JYMessageViewController alloc]init];
    [self addTabBarWithVC:message title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
   
    JYDiscoveryViewController *discovery = [[JYDiscoveryViewController alloc]init];
    [self addTabBarWithVC:discovery title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
   
    JYMeViewController *me = [[JYMeViewController alloc]init];
    [self addTabBarWithVC:me title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    JYTabBar *tabBar = [[JYTabBar alloc]init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}
/**
 *  封装TabBar控制器
 *
 *  @param vc            每一个VC
 *  @param title         TabBar标题
 *  @param image         正常状态下的图片
 *  @param selectedImage 选中状态下的图片
 */
-(void)addTabBarWithVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    //view背景
    //vc.view.backgroundColor = JYRandomColor;
    vc.title = title;
    //设置图片
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置文字样式
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //没有选择状态下字体颜色
    NSMutableDictionary *normalTextAttrs = [NSMutableDictionary dictionary];
    normalTextAttrs[NSForegroundColorAttributeName] = JYColor(123, 123, 123);
    //设置文字的样式
    [vc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:normalTextAttrs forState:UIControlStateNormal];
    JYNavigationController *navigation = [[JYNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:navigation];
}
#pragma mark-tabBarDelegate
-(void)tabBarDidClicktarBarBtn:(JYTabBar *)tabBar{
    
    JYCenterAddView *addView = [JYCenterAddView addView];
    self.addView = addView;
    addView.delegate = self;
    addView.y =20;
    addView.width = [UIScreen mainScreen].bounds.size.width;
    addView.height = [UIScreen mainScreen].bounds.size.height;
    //显示中间按钮菜单
    [addView show];
    
}
-(void)editorText:(UIButton *)buttnon{
    
    [self.addView dismiss];
    JYSendStatusViewController *send = [[JYSendStatusViewController alloc]init];
    JYNavigationController *navigation = [[JYNavigationController alloc]initWithRootViewController:send];
    
    [self presentViewController:navigation animated:YES completion:nil];
}
@end
