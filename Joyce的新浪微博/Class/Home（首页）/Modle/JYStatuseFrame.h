//
//  JYStatuseFrame.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/13.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYStatuses.h"
#import "JYStatusePhotosView.h"

//昵称字体
#define JYStatusCellFontName [UIFont boldSystemFontOfSize:15]
//时间字体
#define JYStatusCellTimeName [UIFont systemFontOfSize:11]
//来源字体
#define JYStatusCellSourceName [UIFont systemFontOfSize:11]
//正文字体
#define JYStatusCellContentName [UIFont systemFontOfSize:15]
//转发微博正文字体
#define JYRetweetStatusCellContentName [UIFont systemFontOfSize:14]

@interface JYStatuseFrame : NSObject

@property(nonatomic,strong)JYStatuses *statuse;
/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewFrame;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewFrame;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewFrame;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewFrame;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelFrame;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelFrame;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelFrame;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelFrame;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewFrame;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelFrame;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotoViewFrame;

/** 工具条 */
@property(nonatomic,assign)CGRect toolBarFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@property(nonatomic,strong)JYStatusePhotosView *photosView;

@end
