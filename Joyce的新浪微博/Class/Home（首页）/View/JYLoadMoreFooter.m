//
//  JYLoadMoreFooter.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/12.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYLoadMoreFooter.h"
#import "JYActivity.h"
@implementation JYLoadMoreFooter

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = JYColor(211, 211, 211);
        self.width = [UIScreen mainScreen].bounds.size.width;
        self.height = 40;
        JYActivity *myactivity=[[JYActivity alloc]initWithFrame:CGRectMake(-40, 0, self.width, 40)];
        [myactivity startAnimating];
        [self addSubview:myactivity];

    }
    return self;
}

+(instancetype)footer{
    
    return [[self alloc]init];
}

@end
