//
//  JYSendStatusToolBar.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/7/3.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYSendStatusToolBar.h"

@implementation JYSendStatusToolBar

-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setButtonWithImage:@"compose_camerabutton_background" HeightImage:@"compose_camerabutton_background_highlighted" buttonType:JYSendStatusToolbarButtonTypeCamera];
        
        [self setButtonWithImage:@"compose_toolbar_picture" HeightImage:@"compose_toolbar_picture_highlighted" buttonType:JYSendStatusToolbarButtonTypePicture];

        
        [self setButtonWithImage:@"compose_mentionbutton_background" HeightImage:@"compose_mentionbutton_background_highlighted" buttonType:JYSendStatusToolbarButtonTypeMention];

        
        [self setButtonWithImage:@"compose_trendbutton_background" HeightImage:@"compose_trendbutton_background_highlighted" buttonType:JYSendStatusToolbarButtonTypeTrend];

        
        [self setButtonWithImage:@"compose_emoticonbutton_background" HeightImage:@"compose_emoticonbutton_background_highlighted" buttonType:JYSendStatusToolbarButtonTypeEmotion];

    }
    return self;
}
-(void)setButtonWithImage:(NSString *)image HeightImage:(NSString *)heigtImage buttonType:(JYSendStatusToolbarButtonType)type{
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.tag = type;
    [btn setImage:[UIImage imageNamed:heigtImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count  = self.subviews.count;
    CGFloat btnH  =self.height;
    CGFloat btnW = self.width/count;
    for (int i=0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.height = btnH;
        btn.width = btnW;
        btn.x = i*btnW;
    }
}
-(void)clickBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(sendStatusWithToolBar:clickBtnType:)]) {
        [self.delegate sendStatusWithToolBar:self clickBtnType:btn.tag];
    }
}
@end
