//
//  UIBarButtonItem+Tool.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/16.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Tool)
+(UIBarButtonItem *)itemWithTarget:(id)target acction:(SEL)acction image:(NSString *)image lightImage:(NSString *)lightImage;
+(UIBarButtonItem *)ml_itemWithTarget:(id)target acction:(SEL)acction;
@end
