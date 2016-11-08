//
//  JYTabBar.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/23.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYTabBar.h"
@interface JYTabBar()
@property(nonatomic,strong)UIButton *tabarButton;
@end

@implementation JYTabBar
@dynamic delegate;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        //添加一个加号按钮到tabar中
        UIButton *tarBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tarBarBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [tarBarBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [tarBarBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [tarBarBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [tarBarBtn addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
        tarBarBtn.size = tarBarBtn.currentBackgroundImage.size;
        [self addSubview:tarBarBtn];
        self.tabarButton = tarBarBtn;

    }
    return self;
}
/**
 *  点击加哈按钮
 */
-(void)clickAddButton{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClicktarBarBtn:)]) {
        [self.delegate tabBarDidClicktarBarBtn:self];
    }
}
-(void)layoutSubviews{
    //一定记得写
    [super layoutSubviews];
    //添加加号按钮的位置
    self.tabarButton.centerX = self.width/2;
    self.tabarButton.centerY = self.height/2;
    //设置其他按钮的位置
    //每个tarBar的宽度
    CGFloat tabarButtonWidth = self.width/5;
    CGFloat tabarButtonIndex = 0;
    for (UIView *cilde in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([cilde isKindOfClass:class]) {
            cilde.width = tabarButtonWidth;
            cilde.x = tabarButtonWidth*tabarButtonIndex;
            tabarButtonIndex++;
            if (tabarButtonIndex==2) {
                tabarButtonIndex++;
            }
        }
    }
    
}
@end
