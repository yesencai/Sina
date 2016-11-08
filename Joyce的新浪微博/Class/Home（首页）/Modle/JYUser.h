//
//  JYUser.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/9.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    JYUserVerifiedTypeNone = -1,//普通用户，没有认证
    JYUserVerifiedTypePersonal = 0,//个人认证
    JYUserVerifiedTypeOrgEnterprice = 2,//企业官方
    JYUserVerifiedTypeOrgMedia = 3,//媒体官方
    JYUserVerifiedTypeOrgWebsite = 5,//网站官方
    JYUserVerifiedTypeDaren = 220  //微博达人
}JYUserVerifiedType;
@interface JYUser : NSObject
/**
 *  字符串型的微博ID
 */
@property(nonatomic,strong)NSString *idstr;
/**
 *  微博好友名称
 */
@property(nonatomic,strong)NSString *name;
/**
 *  微博缩略图50×50像素
 */
@property(nonatomic,strong)NSString *profile_image_url;
/**
 *  微博会员类型>2代表是会员
 */
@property(nonatomic,assign)int mbtype;
/**
 *  微博等级
 */
@property(nonatomic,assign)int mbrank;
@property(nonatomic,assign)BOOL isVip;
/**
 *  微博认证类型
 */
@property(nonatomic,assign)JYUserVerifiedType verified_type;

@end
