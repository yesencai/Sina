//
//  NSDate+Extension.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/16.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  判断时间是否是今年
 *
 */
-(BOOL)isThisYear;
/**
 *  判断时间是否是昨天
 *
 */
-(BOOL)isYesterDay;
/**
 *  判断时间是否是今天
 *
 */
-(BOOL)isThisDay;

@end
