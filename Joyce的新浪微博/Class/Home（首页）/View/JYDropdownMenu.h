//
//  JYDropdownMunu.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/22.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//  //点击微博昵称下拉菜单

#import <UIKit/UIKit.h>
@class JYDropdownMenu;
@protocol JYDropdownMenuDelegate <NSObject>
@optional
-(void)dropdownMenuClickDismiss:(JYDropdownMenu *)menu;
-(void)dropdownMenuClickShow:(JYDropdownMenu *)menu;

@end
@interface JYDropdownMenu : UIView
/**
 *  JYDropdownMenuDelegate
 */
@property(nonatomic,weak)id<JYDropdownMenuDelegate>delegate;

/**
 *  外部传递进来的内容
 */
@property(nonatomic,strong)UIView *content;
/**
 *  外部传递进来的控制器
 */
@property(nonatomic,strong)UIViewController *contentController;
/**
 *  下拉菜单
 *
 *  @return self
 */

+(instancetype)menu;
/**
 *  显示下拉菜单
 *
 *  @param frame 外部传进来的View
 */
-(void)show:(UIView *)frame;
/**
 *  隐藏下拉菜单
 */
-(void)dissmis;
@end
