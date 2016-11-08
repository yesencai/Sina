//
//  JYTextView.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/7/2.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYTextView.h"
#define JYNSNotificationCenter [NSNotificationCenter defaultCenter]
@implementation JYTextView
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        //创建通知中心，监听文字的改变
        [JYNSNotificationCenter addObserver:self selector:@selector(textViewChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
/**
 *  文字改变时的通知
 */
-(void)textViewChange{
    [self setNeedsDisplay];
}
+(instancetype)textView{
    return  [[self alloc]init];
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    if (self.font) {
        attrs[NSFontAttributeName] = self.font;
    }
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    // 画文字
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 8;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}
/**
 *  移除通知
 */
-(void)dealloc{
    [JYNSNotificationCenter removeObserver:self];
}
@end
