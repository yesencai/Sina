//
//  JYUserInfoFrame.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/24.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYUserInfoFrame.h"
#import "NSString+Size.h"
#define JYBordeX  10
#define JYBordeY  5

@implementation JYUserInfoFrame
-(void)setUserInfo:(JYUserInfo *)userInfo{
    
    _userInfo = userInfo;
    
    //头像的frame
    CGFloat headImageX = JYBordeX;
    CGFloat headImageY = JYBordeY;
    CGFloat headImageW = 50;
    CGFloat headImageH = 50;
    self.headImageFrame = CGRectMake(headImageX, headImageY, headImageW, headImageH);
    
    //昵称frame
    CGFloat nameX = CGRectGetMaxX(self.headImageFrame)+JYBordeX;
    CGFloat nameY = JYBordeX;
    CGSize  nameS = [NSString sizeWithText:userInfo.screen_name font:JYNickNameFont];
    self.screenNameFrame = CGRectMake(nameX, nameY, nameS.width, nameS.height);
    
    //vipframe
    CGFloat vipX = CGRectGetMaxX(self.screenNameFrame)+JYBordeX;
    CGFloat vipY = JYBordeX;
    CGFloat vipW = 30;
    CGFloat vipH = 16;
    self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    
    //简介frame
    CGFloat descriptX = CGRectGetMaxX(self.headImageFrame)+JYBordeX;
    CGFloat descriptY = CGRectGetMaxY(self.screenNameFrame)+JYBordeX;
    CGSize descripS = [NSString sizeWithText:userInfo.descript font:JYDescriptFont];
    self.descriptionFrame = CGRectMake(descriptX, descriptY, descripS.width, descripS.height);
    //View
    CGFloat oneViewX = 0;
    CGFloat oneViewY = 10;
    CGFloat oneViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat oneViewH = CGRectGetMaxY(self.headImageFrame)+JYBordeX;
    self.oneViewFrame = CGRectMake(oneViewX, oneViewY, oneViewW, oneViewH);
    //其他cell    
    self.cellHeight = CGRectGetMaxY(self.oneViewFrame);
    
}
@end
