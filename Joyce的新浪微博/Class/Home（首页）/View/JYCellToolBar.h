//
//  JYCellToolBar.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/15.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JYStatuses;
@interface JYCellToolBar : UIView
/** 微博模型 */
@property(nonatomic,strong)JYStatuses *status;

+(instancetype)toolBar;
@end
