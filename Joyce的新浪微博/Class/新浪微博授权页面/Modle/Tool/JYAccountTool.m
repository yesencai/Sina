//
//  JHAccountTool.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/5.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//  处理帐号相关的所有逻辑判断

#import "JYAccountTool.h"
#define JYAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
@implementation JYAccountTool

+(void)saveAccount:(JYAccount *)account{
    //自定义对象的存储必须用到NSKeyedArchiver
    [NSKeyedArchiver archiveRootObject:account toFile:JYAccountPath];
}
+(JYAccount *)account{
   JYAccount *account =  [NSKeyedUnarchiver unarchiveObjectWithFile:JYAccountPath];
    long long expires_in = [account.expires_in  longLongValue];
    //当前时间
    NSDate *now =[ NSDate date];
    
    //获得过期时间
    NSDate *expires_time = [account.creatTime dateByAddingTimeInterval:expires_in];
    	
    if (NSOrderedAscending != [expires_time compare:now]) {
        return account;
    }
    return nil;
}
@end
