//
//  JYNavigationController.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/16.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYNavigationController.h"
#import "UIBarButtonItem+Tool.h"
@implementation JYNavigationController

+(void)initialize{
    
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    // key：NS****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}
-(void)viewDidLoad{
    [super viewDidLoad];
}
/**
 *  自定义导航控制器push的内容
 *
 *  @param viewController 视图
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    if (self.viewControllers.count>0) {
   
        viewController.hidesBottomBarWhenPushed = YES;
        //返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self acction:@selector(back) image:@"navigationbar_back" lightImage:@"navigationbar_back_highlighted"];
        //更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self acction:@selector(back) image:@"navigationbar_more" lightImage:@"navigationbar_more_highlighted"];

    }
    [super pushViewController:viewController animated:animated];
    
}
/**
 *  返回
 */
-(void)back{
    [self popViewControllerAnimated:YES];
}
/**
 *  更多
 */
-(void)more{
    [self popToRootViewControllerAnimated:YES];
}
@end
