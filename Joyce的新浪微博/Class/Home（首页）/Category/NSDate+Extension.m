//
//  NSDate+Extension.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/16.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//  判断当前时间属于那一年、月、日

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断是否是今年
 *
 */
-(BOOL)isThisYear{
    
    NSDateComponents *createdCmp = [self getCreatedComponentsWithCalendarUnit:NSCalendarUnitYear];
    NSDateComponents *nowCmp = [self getNowComponentsWithCalendarUnit:NSCalendarUnitYear];
    if (createdCmp.year==nowCmp.year) {
        return YES;
    }
    return NO;
}
/**
 *  是否是昨天
 *
 */
-(BOOL)isYesterDay{
    NSCalendarUnit unit =NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *cmp = [self getTimeComponentsDifferenceWithCalendarUnit:unit];

    if (cmp.year==0&&cmp.month==0&&cmp.day==1) {
        return YES;
    }
    return NO;
}
/**
 *  判断时间是否是今天
 *
 */
-(BOOL)isThisDay{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //创建时间
    NSString *createdStr = [fmt stringFromDate:self];
    //现在时间
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    if ([createdStr isEqualToString:nowStr]) {
        return YES;
    }
    return NO;
}
/**
 *  判断某个时间的年月日时分秒
 *
 *  @param unit 年、月、日
 */
-(NSDateComponents *)getCreatedComponentsWithCalendarUnit:(NSCalendarUnit)unit{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *createdCmp =  [calendar components:NSCalendarUnitYear fromDate:self];
    return createdCmp;
}
/**
 *  判断当前时间的年月日时分秒
 *
 *  @param unit 年、月、日
 *
 */
-(NSDateComponents *)getNowComponentsWithCalendarUnit:(NSCalendarUnit)unit{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *nowCmp =  [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return nowCmp;
}
/**
 *  得到时间差
 *
 *  @param unit 年、月、日
 *
 */
-(NSDateComponents *)getTimeComponentsDifferenceWithCalendarUnit:(NSCalendarUnit)unit{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *createdStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    NSDate *createdDate = [fmt dateFromString:createdStr];
    NSDate *nowDate = [fmt dateFromString:nowStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //得到时间差
    NSDateComponents *cmp =  [calendar components:unit fromDate:createdDate toDate:nowDate options:0];
    return cmp;
}
@end
