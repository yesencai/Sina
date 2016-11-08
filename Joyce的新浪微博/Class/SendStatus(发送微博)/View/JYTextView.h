//
//  JYTextView.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/7/2.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYTextView : UITextView
/**
 *  占位字符
 */
@property(nonatomic,copy)NSString *placeholder;
/**
 *  占位字符颜色
 */
@property(nonatomic,strong)UIColor *placeholderColor;

+(instancetype)textView;
@end
