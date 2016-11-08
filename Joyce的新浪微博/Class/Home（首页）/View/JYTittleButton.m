//
//  TittleButton.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/23.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//  微博首页昵称布局

#import "JYTittleButton.h"

@implementation JYTittleButton

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //设置标题颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置标题字体大小
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        //设置标题的图片
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}
/**
 *  设置标题
 *
 *  @return self
 */
+(instancetype)button{
    
    return [[self alloc]init];
}

-(void)layoutSubviews{
   
    [super layoutSubviews];
   
    //1.计算titleLabel的frame
    self.titleLabel.x = CGRectGetMinX(self.bounds);
    //2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}





@end
