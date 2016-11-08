//
//  JYAboutMeCell.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/23.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYUserInfoFrame.h"
@interface JYAboutMeCell : UITableViewCell
/**
 *  其他cell上面的View
 */
@property(nonatomic,strong)UIView *otherView;
@property(nonatomic,strong)JYUserInfoFrame *userInfoFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
