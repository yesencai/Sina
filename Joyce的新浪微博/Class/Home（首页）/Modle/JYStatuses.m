//
//  JYStatus.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/9.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYStatuses.h"
#import "MJExtension.h"
#import "JYPhoto.h"
#import "NSDate+Extension.h"
@implementation JYStatuses

-(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[JYPhoto class]};
}
/**
 *  发微博时间
 *
 */
-(NSString *)created_at{

    //一分钟内 返回刚刚
    //一分钟~59分钟内：xx分钟前
    //大于60分钟 xx小时前
    //create_at ==Jun 16 22:46:51 +0800 2015;
    //E：代表星期几
    //M:月份
    //d：日期
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //真机调试转换欧美时间需要locale
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    //设置日期的格式，声明字符串每个字符之间的含义
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //微博创建日期
    NSDate *createdDate = [formatter dateFromString:_created_at];
    //手机当前时间
    NSDate *nowDate = [NSDate date];
    //创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    //得到时间差
   NSDateComponents *cmp =  [calendar components:unit fromDate:createdDate toDate:nowDate options:0];
    if ([createdDate isThisYear]) {//判断是否是今年
        
        if ([createdDate isThisDay]) {//是否今天
            if (cmp.hour>=1) {
                return [NSString stringWithFormat:@"%ld 小时前",cmp.hour];

            }else if (cmp.minute>1){
                return [NSString stringWithFormat:@"%ld 分钟前",cmp.minute];

            }else{
                return @"刚刚";
            }
            
        }else if ([createdDate isYesterDay]){//判断是否是昨天
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:createdDate];
        }else{
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:createdDate];
        }
        
    }else{
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:createdDate];
    }
    
}
/**
 *  微博来源
 *
 */
- (void)setSource:(NSString *)source
{
    if (!source||source==nil||[source isEqualToString:@""]) {
        return;
    }
    // 正则表达式 NSRegularExpression
    // 截串 NSString
    NSRange range;
    range.location = [source rangeOfString:@">"].location+1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    //range.length = [source rangeOfString:@"<" options:NSBackwardsSearch].length;
        _source = [NSString stringWithFormat:@"来自 %@", [source substringWithRange:range]];
}
@end
