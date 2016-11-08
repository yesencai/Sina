//
//  JYStatuseCell.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/13.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYStatuseCell.h"
#import "UIImageView+WebCache.h"
#import "JYStatuses.h"
#import "JYUser.h"
#import "JYPhoto.h"
#import "JYCellToolBar.h"
#import "JYIconImageView.h"
#import "JYStatusePhotosView.h"
@interface JYStatuseCell()
/* 原创微博 */

/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) JYIconImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) JYStatusePhotosView *photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博正文 + 昵称 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发配图 */
@property (nonatomic, weak) JYStatusePhotosView *retweetPhotosView;

/**
 *  转发、评论、点赞、工具栏
 */
@property(nonatomic,weak)JYCellToolBar *toolBar;

@end

@implementation JYStatuseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    JYStatuseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =  [[JYStatuseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
/**
 *  初始化所有一次性的控件
 *
 *  @param style           样式
 *  @param reuseIdentifier 标识
 *
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始化原创微博
        [self setupOriginal];
        
        // 初始化转发微博
        [self setupRetweet];
        
        //转发、评论、点赞工具条
        [self setupToolBar];
    }
    return self;
}
/**
 *  转发、点赞、评论工具条
 */
-(void)setupToolBar{
    
    //工具条
    JYCellToolBar *toolBar = [JYCellToolBar toolBar];
    
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
    
}
/**
 *  转发微博
 */
-(void)setupRetweet{
    
    /** 转发微博整体 */
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = JYColor(240, 240, 240);
    self.retweetView = retweetView;
    [self.contentView addSubview:retweetView];
    
    /** 转发微博正文 + 昵称 */
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = JYRetweetStatusCellContentName;
    self.retweetContentLabel = retweetContentLabel;
    [retweetView addSubview:retweetContentLabel];
    
    /** 转发配图 */
    JYStatusePhotosView *retweetPhotosView = [[JYStatusePhotosView alloc]init];
    self.retweetPhotosView = retweetPhotosView;
    [retweetView addSubview:retweetPhotosView];

}
/**
 *  原创微博
 */
-(void)setupOriginal{
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
    self.originalView = originalView;
    [self.contentView addSubview:originalView];
    
    /** 头像 */
    JYIconImageView *iconView = [[JYIconImageView alloc]init];
    self.iconView = iconView;
    [originalView addSubview:iconView];
    
    /** 会员图标 */
    UIImageView *vipView =[[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    
    self.vipView = vipView;
    [originalView addSubview:vipView];
    
    /** 配图 */
    JYStatusePhotosView *photosView =[[JYStatusePhotosView alloc]init];
    self.photosView = photosView;
    [originalView addSubview:photosView];
    
    /** 昵称 */
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = JYStatusCellFontName;
    self.nameLabel = nameLabel;
    [originalView addSubview:nameLabel];
    
    /** 时间 */
    UILabel *timeLabel =[[UILabel alloc]init];
    timeLabel.textColor = [UIColor orangeColor];
    timeLabel.font = JYStatusCellTimeName;
    self.timeLabel = timeLabel;
    [originalView addSubview:timeLabel];
    
    /** 来源 */
    UILabel *sourceLabel =[[UILabel alloc]init];
    sourceLabel.textColor = [UIColor grayColor];
    sourceLabel.font = JYStatusCellSourceName;
    self.sourceLabel = sourceLabel;
    [originalView addSubview:sourceLabel];
    
    /** 正文 */
    UILabel *contentLabel =[[UILabel alloc]init];
    contentLabel.font = JYStatusCellContentName;
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
    [originalView addSubview:contentLabel];
    
}
-(void)setStatusFrame:(JYStatuseFrame *)statusFrame{
    
    _statusFrame = statusFrame;
    //微博信息
    JYStatuses *status = statusFrame.statuse;
    //用户信息
    JYUser *user = status.user;
    
    /** 原创微博整体 */
    self.originalView.frame = statusFrame.originalViewFrame;
    
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewFrame;
    self.iconView.user = user;
    
    /** 会员图标 */
    self.vipView.frame = statusFrame.vipViewFrame;
    if (user.isVip) {
        self.vipView.hidden = NO;
        NSString *vipStr = [[NSString alloc]initWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipStr];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    /** 配图 */
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photoViewFrame;
        self.photosView.photosArray = status.pic_urls;
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
    
    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLabelFrame;
    self.nameLabel.text = user.name;
    
    /** 时间 */
    self.timeLabel.frame = statusFrame.timeLabelFrame;
    self.timeLabel.text = status.created_at;
    
    /** 来源 */
    self.sourceLabel.frame = statusFrame.sourceLabelFrame;
    self.sourceLabel.text = status.source;
    
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelFrame;
    self.contentLabel.text = status.text;
    
    /** 转发微博*/
    if (status.retweeted_status) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewFrame;
        /** 转发微博正文 + 昵称 */
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelFrame;
        NSString *contentText = [NSString stringWithFormat:@"@%@ %@",status.retweeted_status.user.name,status.retweeted_status.text];
        self.retweetContentLabel.text = contentText;
        if (status.retweeted_status.pic_urls.count) {
            /** 转发配图 */
            self.retweetPhotosView.frame = statusFrame.retweetPhotoViewFrame;
            self.retweetPhotosView.photosArray = status.retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
        }else{
            self.retweetPhotosView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
    
    /** 工具条 */
    self.toolBar.frame = statusFrame.toolBarFrame;
    self.toolBar.status = status;
    
}
@end
