//
//  JYUser.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/9.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYUser.h"

@implementation JYUser
-(void)setMbtype:(int)mbtype{
    
    _mbtype = mbtype;
    self.isVip = _mbtype>2;
}
@end
