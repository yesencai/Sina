//
//  JYDropdownMunu.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/22.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYDropdownMenu.h"
@interface JYDropdownMenu()

//什么时候用到，就什么时候显示容器
@property(nonatomic,strong)UIImageView *contentImageView;
@end

@implementation JYDropdownMenu

-(UIImageView *)contentImageView{
    
    if (!_contentImageView) {
        //添加下拉图片
        _contentImageView = [[UIImageView alloc]init];
        _contentImageView.userInteractionEnabled = YES;
        _contentImageView.image = [UIImage imageNamed:@"popover_background"];
        [self addSubview:_contentImageView];
    }
    return _contentImageView;
}
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        //清楚背景颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
/**
 *  创建下拉菜单
 *
 *  @return self
 */
+(instancetype)menu{
    
    return [[self alloc]init];
}
/**
 *  显示下拉菜单
 */
-(void)show:(UIView *)frame{
    //拿到最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //添加自己到窗口上
    [window addSubview:self];

    CGRect newFrame = [frame convertRect:frame.bounds toView:window];
    
    //设置容器的位置
    self.contentImageView.y = CGRectGetMaxY(newFrame);

    self.contentImageView.centerX = CGRectGetMidX(newFrame);
    //设置frame
    self.frame = window.bounds;
    if ([self.delegate respondsToSelector:@selector(dropdownMenuClickShow:)]) {
        [self.delegate dropdownMenuClickShow:self];
    }
}
/**
 *  隐藏下拉菜单
 */
-(void)dissmis{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuClickDismiss:)]) {
        [self.delegate dropdownMenuClickDismiss:self];
    }
}
/**
 *  重新set方法保存content
 *
 *  @param content 外部传递进来的内容
 */
-(void)setContent:(UIView *)content{
    _content = content;
    //调整内容的位置
    content.y = 15;
    content.x = 10;
    //------CGRectGetMaxY(content.frame) content最大的y值
    
    //设置容器的高度
    self.contentImageView.height = CGRectGetMaxY(content.frame)+10;
    self.contentImageView.width = CGRectGetMaxX(content.frame)+10;
    content.width= self.contentImageView.width-2*content.x;

    //把内容添加到容器上
    [self.contentImageView addSubview:_content];
}
/**
 *  外部传递进来的控制器
 *
 *  @param contentController 外部传递进来的控制器
 */
-(void)setContentController:(UIViewController *)contentController{
    
    _contentController = contentController;
    self.content = contentController.view;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //隐藏下拉菜单
    [self dissmis];
}
@end
