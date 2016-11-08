//
//  JYUserInfoFrame.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/24.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYUserInfo.h"
//昵称字体
#define JYNickNameFont [UIFont systemFontOfSize:14]
//简介字体
#define JYDescriptFont [UIFont systemFontOfSize:12]

@interface JYUserInfoFrame : NSObject

@property(nonatomic,assign)CGRect oneViewFrame;

/**
 *  头像frame
 */
@property(nonatomic,assign)CGRect headImageFrame;
/**
 *  昵称frame
 */
@property(nonatomic,assign)CGRect screenNameFrame;
/**
 *  简介frame
 */
@property(nonatomic,assign)CGRect descriptionFrame;
/**
 *  vipframe
 */
@property(nonatomic,assign)CGRect vipFrame;
/**
 *  用户信息
 */
@property(nonatomic,strong)JYUserInfo *userInfo;
/**
 *  每个cell的高度
 */
@property(nonatomic,assign)CGFloat cellHeight;

@end
