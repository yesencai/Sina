//
//  JYStatuseCell.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/13.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYStatuseFrame.h"
@interface JYStatuseCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) JYStatuseFrame *statusFrame;

@end
