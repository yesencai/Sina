//
//  JYSendStatusToolBar.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/7/3.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum:NSInteger{
    
    JYSendStatusToolbarButtonTypeCamera =1, // 拍照
    JYSendStatusToolbarButtonTypePicture, // 相册
    JYSendStatusToolbarButtonTypeMention, // @
    JYSendStatusToolbarButtonTypeTrend, // #
    JYSendStatusToolbarButtonTypeEmotion // 表情
}JYSendStatusToolbarButtonType;

@class JYSendStatusToolBar;
@protocol JYSendStatusToolBarDelegate <NSObject>

-(void)sendStatusWithToolBar:(JYSendStatusToolBar *)toolBar clickBtnType:(JYSendStatusToolbarButtonType)btnType;
@end

@interface JYSendStatusToolBar : UIView
@property(nonatomic,weak)id <JYSendStatusToolBarDelegate>delegate;

@end
