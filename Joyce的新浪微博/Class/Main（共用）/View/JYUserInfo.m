//
//  JYUserInfo.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/24.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYUserInfo.h"
#import "MJExtension.h"
@implementation JYUserInfo
-(void)setMbtype:(int)mbtype{
    
    _mbtype = mbtype;
    self.isVip = _mbtype>2;
}
-(NSDictionary *)replacedKeyFromPropertyName{
    
    return @{@"descript":@"description"};
}
@end
