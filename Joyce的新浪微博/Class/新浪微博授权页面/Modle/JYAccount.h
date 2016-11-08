//
//  JYAccount.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/4.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYAccount : NSObject<NSCoding>
/**
 *  接口获取授权后的access_token
 */
@property(nonatomic,copy)NSString *access_token;
/**
 *  access_token 的生命周期单位秒
 */
@property(nonatomic,copy)NSString *expires_in;
@property(nonatomic,copy)NSString *remind_in;
/**
 *  当前授权用户id
 */
@property(nonatomic,copy)NSString *uid;
/**
 *  access_token的获取时间
 */
@property(nonatomic,copy)NSDate *creatTime;
/**
 *  微博标题
 */
@property(nonatomic,copy)NSString *name;
/**
 *  将字典转成模型
 *
 *  @param dic 字典对象
 *
 *  @return 返回模型对象
 */
+(instancetype)accountWithDic:(NSDictionary *)dic;


@end
