//
//  JYActivity.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/12.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYActivity.h"

@implementation JYActivity
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.activity=[[UILabel alloc]init];
        self.activity.x = 59;
        
        self.activity.width = [UIScreen mainScreen].bounds.size.width;
        self.activity.height = 40;
        self.activity.textAlignment = NSTextAlignmentCenter;
        self.activity.text=@"正在加载...";
        self.activity.textColor = [UIColor grayColor];
        self.activity.font=[UIFont systemFontOfSize:16];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:self.activity];
    }
    return self;
}
@end
