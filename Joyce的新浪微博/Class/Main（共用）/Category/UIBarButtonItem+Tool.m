//
//  UIBarButtonItem+Tool.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/16.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "UIBarButtonItem+Tool.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Tool)
/**
 *  设置导航栏左右按钮
 *
 *  @param acction    按钮点击事件
 *  @param image      正常状态下图片
 *  @param lightImage 点击状态下的图片
 *
 *  @return UIBarButtonItem
 */

+(UIBarButtonItem *)itemWithTarget:(id)target acction:(SEL)acction image:(NSString *)image lightImage:(NSString *)lightImage{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:acction forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:lightImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
+(UIBarButtonItem *)ml_itemWithTarget:(id)target acction:(SEL)acction{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:acction forControlEvents:UIControlEventTouchUpInside];
    button.size = CGSizeMake(40, 40);
    UIImageView* mainImageView= [[UIImageView alloc]init];
    mainImageView.userInteractionEnabled = NO;
    mainImageView.frame = button.bounds;
    mainImageView.animationImages = @[[UIImage imageNamed:@"showVoice-voice1"],[UIImage imageNamed:@"showVoice-voice2"],[UIImage imageNamed:@"showVoice-voice3"],[UIImage imageNamed:@"showVoice-voice4"],[UIImage imageNamed:@"showVoice-voice5"],[UIImage imageNamed:@"showVoice-voice6"],[UIImage imageNamed:@"showVoice-voice7"],[UIImage imageNamed:@"showVoice-voice8"]];
    [mainImageView setAnimationDuration:1.5f];
    [mainImageView setAnimationRepeatCount:0];
    [mainImageView startAnimating];
    [button addSubview:mainImageView];
    [self rotating:mainImageView];

    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
+ (void)rotating:(UIImageView *)imageView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 2.设置基本动画属性
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2);
    animation.repeatCount = NSIntegerMax;
    animation.duration = 10;
    // 3.添加动画到图层上
    [imageView.layer addAnimation:animation forKey:nil];
}
@end
