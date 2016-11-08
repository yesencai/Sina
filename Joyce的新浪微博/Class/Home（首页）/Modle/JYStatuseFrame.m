//
//  JYStatuseFrame.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/13.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYStatuseFrame.h"
#import "JYUser.h"
#import "JYPhoto.h"
#import "NSString+Size.h"
#define JYStatusCellSorderW 10
//cell之间的距离
#define JYStatusCellSpacingH 10

@implementation JYStatuseFrame
-(id)init{
    self = [super init];
    if (self) {
        
        self.photosView = [JYStatusePhotosView statuse];
    }
    return self;
}
-(void)setStatuse:(JYStatuses *)statuse{
    _statuse = statuse;
    JYUser *user = statuse.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    /** 原创微博 */

    /** 头像 */
    CGFloat iconWH = 40;
    CGFloat iconX = JYStatusCellSorderW;
    CGFloat iconY = JYStatusCellSorderW;
    self.iconViewFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewFrame)+JYStatusCellSorderW;
    CGFloat nameY = iconY;
    CGSize  nameSizi = [NSString sizeWithText:user.name font:JYStatusCellFontName];
    self.nameLabelFrame = CGRectMake(nameX, nameY, nameSizi.width, nameSizi.height);
    
    /** 会员图标 */
    if (user.isVip) {//判断是否是微博会员
        CGFloat vipX = CGRectGetMaxX(self.nameLabelFrame)+JYStatusCellSorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSizi.height;
        CGFloat vipW = 14;
        self.vipViewFrame = CGRectMake(vipX, vipY, vipW, vipH);
        
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelFrame)+JYStatusCellSorderW;
    CGSize timeSize = [NSString sizeWithText:statuse.created_at font:JYStatusCellTimeName];
    self.timeLabelFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame)+JYStatusCellSorderW;
    CGFloat sourceY = timeY;
    CGSize  sourceSize = [NSString sizeWithText:statuse.source font:JYStatusCellSourceName];
    self.sourceLabelFrame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);

    /** 正文 */
    CGFloat contentX = JYStatusCellSorderW;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewFrame), CGRectGetMaxY(self.sourceLabelFrame))+JYStatusCellSorderW;
    CGFloat contentW = cellW-3*JYStatusCellSorderW;
    CGSize  contentSize = [NSString sizeWithText:statuse.text font:JYStatusCellContentName maxW:contentW];
    self.contentLabelFrame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    /** 配图 */
    
       CGFloat originalH;
    if (statuse.pic_urls.count) {
        
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelFrame)+JYStatusCellSorderW;
        CGSize  photoViewW = [self.photosView sizeWithCount:statuse. pic_urls.count url:statuse.pic_urls];
        self.photoViewFrame = CGRectMake(photoX, photoY, photoViewW.width, photoViewW.height);

        //有图片，原创微博整体高度为图片最大Y值
         originalH = CGRectGetMaxY(self.photoViewFrame)+JYStatusCellSorderW;
    }else{
        //没有图片，原创微博整体高度为正文最大Y值
         originalH = CGRectGetMaxY(self.contentLabelFrame)+JYStatusCellSorderW;
    }
    /** 原创微博整体 */
    CGFloat originalW = cellW;
    self.originalViewFrame = CGRectMake(0, 10, originalW, originalH);
    
    /** 转发微博微博 */
    CGFloat toolBarY = 0;
    /** 转发微博正文*/
    if (statuse.retweeted_status) {//如果有转发微博
        CGFloat retweetContentX = JYStatusCellSorderW;
        CGFloat retweetContentY = JYStatusCellSorderW;
        NSString *contentText = [NSString stringWithFormat:@"@%@ %@",statuse.retweeted_status.user.name,statuse.retweeted_status.text];
        CGFloat retweetContentW = cellW-3*JYStatusCellSorderW;
        CGSize retweetContentSize = [NSString sizeWithText:contentText font:JYRetweetStatusCellContentName maxW:retweetContentW];
        self.retweetContentLabelFrame =CGRectMake(retweetContentX, retweetContentY, retweetContentSize.width, retweetContentSize.height);
        CGFloat retweetH = 0;
        if (statuse.retweeted_status.pic_urls.count) {//如果转发微博有图片
    /** 转发微博配图*/
            CGFloat retweetPhotoX = retweetContentX;
            CGSize retweetPhotoWH  = [self.photosView sizeWithCount:statuse.retweeted_status.pic_urls.count url:statuse.retweeted_status.pic_urls];
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelFrame)+JYStatusCellSorderW;
            self.retweetPhotoViewFrame = CGRectMake(retweetPhotoX,retweetPhotoY, retweetPhotoWH.width, retweetPhotoWH.height);
            retweetH = CGRectGetMaxY(self.retweetPhotoViewFrame)+JYStatusCellSorderW;
        }else{
            retweetH = CGRectGetMaxY(self.retweetContentLabelFrame)+JYStatusCellSorderW;
        }
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewFrame);
        CGFloat retweetW = cellW;
        self.retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolBarY = CGRectGetMaxY(self.retweetViewFrame);
    }else{
        toolBarY = CGRectGetMaxY(self.originalViewFrame);
    }
    CGFloat toolBarX = 0;
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = 35;
    self.toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
   //cell的高度
    self.cellHeight = CGRectGetMaxY(self.toolBarFrame);
}

@end
