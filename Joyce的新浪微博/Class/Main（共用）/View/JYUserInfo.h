//
//  JYUserInfo.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/24.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYUserInfo : NSObject
/**
 *  用户昵称
 */
@property(nonatomic,copy)NSString *screen_name;
/**
 *  头像
 */
@property(nonatomic,copy)NSString *profile_image_url;
/**
 *  用户简介，个人描述
 */
@property(nonatomic,copy)NSString *descript;
/**
 *  粉丝数
 */
@property(nonatomic,assign)int followers_count;
/**
 *  微博数
 */
@property(nonatomic,assign)int statuses_count;
/**
 *  关注数
 */
@property(nonatomic,assign)int friends_count;
/**
 *  是否加V
 */
@property(nonatomic,assign)BOOL verified;
/**
 *  微博会员类型>2代表是会员
 */
@property(nonatomic,assign)int mbtype;
/**
 *  微博等级
 */
@property(nonatomic,assign)int mbrank;
@property(nonatomic,assign)BOOL isVip;

@end
