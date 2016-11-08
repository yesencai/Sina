//
//  JYAboutMeCell.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/23.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYAboutMeCell.h"
#import "UIImageView+WebCache.h"
@interface JYAboutMeCell()
/**
 *  第一个cell的View
 */
@property(nonatomic,strong)UIView *oneView;


/**
 *  微博头像
 */
@property(nonatomic,strong)UIImageView *headImage;
/**
 *  昵称
 */
@property(nonatomic,strong)UILabel *name;
/**
 *  简介
 */
@property(nonatomic,strong)UILabel *descript;
/**
 *  会员
 */
@property(nonatomic,strong)UIImageView *vip;

@end
@implementation JYAboutMeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    tableView.y = 10;
    JYAboutMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =  [[JYAboutMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
   self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self oneCell];
    }
    return self;
    
}
//第一个cell
-(void)oneCell{
    /**
     * 第一个cell上面的View
     */
    UIView *oneView = [[UIView alloc]init];
    oneView.backgroundColor = [UIColor whiteColor];
    self.oneView = oneView;
    [self.contentView addSubview:oneView];
    
    //初始化控件
    //头像
    UIImageView *headImage = [[UIImageView alloc]init];
    self.headImage = headImage;
    [oneView addSubview:headImage];
    //昵称
    UILabel *name = [[UILabel alloc]init];
    name.font = JYNickNameFont;
    self.name = name;
    [oneView addSubview:name];
    //简介
    UILabel *descript = [[UILabel alloc]init];
    descript.font = JYDescriptFont;
    self.descript = descript;
    [oneView addSubview:descript];
    //会员
    UIImageView *vip = [[UIImageView alloc]init];
    self.vip = vip;
    [oneView addSubview:vip];
    
    
}
-(void)setUserInfoFrame:(JYUserInfoFrame *)userInfoFrame{
    
    _userInfoFrame = userInfoFrame;
    JYUserInfo *userInfo = userInfoFrame.userInfo;
    
    self.oneView.frame = userInfoFrame.oneViewFrame;
    /**
     *  头像
     */
    self.headImage.frame = userInfoFrame.headImageFrame;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:userInfo.profile_image_url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    /**
     *  昵称
     */
    self.name.frame = userInfoFrame.screenNameFrame;
    self.name.text = userInfo.screen_name;
    
    //简介
    self.descript.frame = userInfoFrame.descriptionFrame;
    self.descript.text = userInfo.descript;
    
    //vip
    self.vip.frame = userInfoFrame.vipFrame;
    if (userInfo.isVip) {
        NSString *str = [NSString stringWithFormat:@"userinfo_membership_level%d",userInfo.mbrank];
        NSString *strH = [NSString stringWithFormat:@"userinfo_membership_level%d_selected",userInfo.mbrank];
        self.vip.image = [UIImage imageNamed:str];
        self.vip.highlightedImage = [UIImage imageNamed:strH];

    }else{
        self.vip.image = [UIImage imageNamed:@"userinfo_membership_expired"];
        self.vip.highlightedImage = [UIImage imageNamed:@"userinfo_membership_expired_selected"];
    }
}
@end
