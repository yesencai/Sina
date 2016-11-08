//
//  JYStatus.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/9.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JYUser;
@interface JYStatuses : NSObject

/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博好友的用户信息
 */
@property (nonatomic, strong) JYUser *user;
/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博缩略图
 */
@property(nonatomic,strong)NSArray *pic_urls;
/**
 *  转发微博的内容
 */
@property (nonatomic, strong) JYStatuses *retweeted_status;
/**
 *  转发次数
 */
@property(nonatomic,assign)int reposts_count;
/**
 *  评论次数
 */
@property(nonatomic,assign)int comments_count;
/**
 *  被赞次数
 */
@property(nonatomic,assign)int attitudes_count;

@end
