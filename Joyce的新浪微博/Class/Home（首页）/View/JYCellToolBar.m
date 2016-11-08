//
//  JYCellToolBar.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/15.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYCellToolBar.h"
#import "JYStatuses.h"
@interface JYCellToolBar()
//转发
@property(nonatomic,weak)UIButton *reweetBut;
//评论
@property(nonatomic,weak)UIButton *commentsBut;
//表态
@property(nonatomic,weak)UIButton *praiseBut;
//存放button的数组
@property(nonatomic,strong)NSMutableArray *btnArray;
//存放分割线的数组
@property(nonatomic,strong)NSMutableArray *lineArray;

@end
@implementation JYCellToolBar

//button数组
- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        self.btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

//分割线数组
- (NSMutableArray *)lineArray
{
    if (!_lineArray) {
        self.lineArray = [[NSMutableArray alloc] init];
    }
    return _lineArray;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        //转发
        self.reweetBut = [self setUpButtonWithTitle:@"转发" icon:@"timeline_icon_retweet"];
        //评论
        self.commentsBut = [self setUpButtonWithTitle:@"评论" icon:@"timeline_icon_comment"];
        //赞
        self.praiseBut = [self setUpButtonWithTitle:@"赞" icon:@"timeline_icon_unlike"];
        //分割线
        [self setupDivider];
        //分割线
        [self setupDivider];
    }
    return self;
}
+(instancetype)toolBar{
    
    return [[self alloc]init];
}
/**
 *  设置子控件
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置转发、评论、赞的frame
   NSInteger btnCount = self.btnArray.count;
    CGFloat btnW =self.width/3;
    CGFloat btnH =35;
    for (int i =0; i<btnCount; i++) {
        UIButton *btn = self.btnArray[i];
        btn.x =i*btnW;
        btn.y =0;
        btn.width = btnW;
        btn.height = btnH;
    }
    //设置分割线的frame
    NSInteger lineCount = self.lineArray.count;
    for (int i =0; i<lineCount; i++) {
        UIImageView *imgView = self.lineArray[i];
        imgView.x = (i+1) * btnW;
        imgView.y = 0;
        imgView.width = 1;
        imgView.height = btnH;
    }
}
/**
 * 添加分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.lineArray addObject:divider];
}
/**
 *  button
 */
-(UIButton *)setUpButtonWithTitle:(NSString *)title icon:(NSString *)icon{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_retweet_background_highlighted"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:button];
    [self.btnArray addObject:button];
    return button;
}
-(void)setStatus:(JYStatuses *)status{
    
    _status = status;
    [self setUpBtnWithCount:status.reposts_count btn:self.reweetBut title:@"转发"];
    [self setUpBtnWithCount:status.comments_count btn:self.commentsBut title:@"评论"];
    [self setUpBtnWithCount:status.attitudes_count btn:self.praiseBut title:@"赞"];

}
-(void)setUpBtnWithCount:(int)count btn:(UIButton *)btn title:(NSString *)title{
    
    if (count||count!=0){
        title = [NSString stringWithFormat:@"%d",count];
        if (count>=10000) {
            title = [NSString stringWithFormat:@"%d万",count/10000];
        }
        [btn setTitle:title forState:UIControlStateNormal];
        
    }else{
        [btn setTitle:title forState:UIControlStateNormal];
    }
}
@end
