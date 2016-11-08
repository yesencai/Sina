//
//  JHAccountTool.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/5.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYAccount.h"
@interface JYAccountTool : NSObject
/**
 *  存储帐号信息
 *
 *  @param account 帐号模型对象
 */
+(void)saveAccount:(JYAccount *)account;
/**
 *  帐号模型对象
 *
 *  @return 返回帐号模型对象（如果过期返回nil）
 */
+(JYAccount *)account;
@end
