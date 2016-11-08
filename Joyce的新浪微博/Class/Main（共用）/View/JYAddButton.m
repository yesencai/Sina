//
//  JYAddButton.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/23.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYAddButton.h"

@implementation JYAddButton
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    
    if (self) {
        
        
    }
    return self;
}
+(instancetype)button{
    
    return [[self alloc]init];
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, JYBtnWidth, JYBtnWidth);//图片的位置大小
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, JYBtnWidth, JYBtnWidth, 30);//文本的位置大小
}
@end
