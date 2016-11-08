//
//  JYCenterAddView.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/23.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYCenterAddView.h"
#import "JYAddButton.h"

/**
 *  屏幕宽度
 */
#define JYKsmWide [UIScreen mainScreen].bounds.size.width
/**
 *  btn距离左边的边距
 */
#define JYBtnBordeWide 40
/**
 *  btn距离上边的边距
 */
#define JYBtnBordeHeight 30
/**
 *  btn左右距离的边距
 */
#define JYBtnBorde ((JYKsmWide-2*JYBtnBordeWide)-3*JYBtnWidth)/2
/**
 *  btn上下距离的边距
 */
#define JYBtnBordeH 40

@interface JYCenterAddView()
/**
 *  存放btn的view
 */
@property(nonatomic,strong)UIView *btnView;

/**
 *  文字
 */
@property(nonatomic,strong)UIButton *textBtn;
/**
 *  相册
 */
@property(nonatomic,strong)UIButton *albumBtn;
/**
 *  相机
 */
@property(nonatomic,strong)UIButton *cameraBtn;
/**
 *  签到
 */
@property(nonatomic,strong)UIButton *signBtn;
/**
 *  点评
 */
@property(nonatomic,strong)UIButton *reviewBtn;
/**
 *  更多
 */
@property(nonatomic,strong)UIButton *moreBtn;
/**
 *  欢迎来到微博
 */
@property(nonatomic,strong)UIImageView *imageView;
/**
 *  底部View
 */
@property(nonatomic,strong)UIView *bottomView;
/**
 *  底部XX
 */
@property(nonatomic,strong)UIImageView *Ximage;

@end

@implementation JYCenterAddView

/**
 *  按钮上面的图片和文字
 *
 *  @param tittle 文字
 *  @param image  图片
 *
 */
-(UIButton *)btnWithTittle:(NSString *)tittle image:(NSString *)image{
    
    JYAddButton *btn = [JYAddButton button];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:tittle forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    return btn;
}
/**
 *  底部View
 *
 */
- (UIView *)bottomView
{
    if (!_bottomView) {
        self.bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bottomView];
    }
    return _bottomView;
}
/**
 *  底部XX按钮
 *
 */
- (UIImageView *)Ximage
{
    if (!_Ximage) {
        self.Ximage = [[UIImageView alloc] init];
        _Ximage.image = [UIImage imageNamed:@"tabbar_compose_background_icon_close"];
        [self.bottomView addSubview:_Ximage];
    }
    return _Ximage;
}
/**
 *  欢迎来到微博字样
 *
 */
- (UIImageView *)imageView
{
    if (!_imageView) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome_android_slogan"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imageView];
    }
    return _imageView;
}
/**
 *  存放btn的view
 *
 */
- (UIView *)btnView
{
    if (!_btnView) {
        self.btnView = [[UIView alloc] init];
        _btnView.backgroundColor =  [UIColor clearColor];
        [self addSubview:_btnView];
    }
    return _btnView;
}
/**
 *  文字
 *
 */
- (UIButton *)textBtn
{
    if (!_textBtn) {
        self.textBtn = [[UIButton alloc] init];
        _textBtn = [self btnWithTittle:@"文字" image:@"tabbar_compose_idea"];
        [_textBtn addTarget:self action:@selector(editorText:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnView addSubview:_textBtn];
    }
    
    return _textBtn;
}
/**
 *  相册
 *
 */
- (UIButton *)albumBtn
{
    if (!_albumBtn) {
        self.albumBtn = [[UIButton alloc] init];
        _albumBtn = [self btnWithTittle:@"相册" image:@"tabbar_compose_photo"];
        [self.btnView addSubview:_albumBtn];
    }
    return _albumBtn;
}
/**
 *  相机
 *
 */
- (UIButton *)cameraBtn
{
    if (!_cameraBtn) {
        self.cameraBtn = [[UIButton alloc] init];
        _cameraBtn = [self btnWithTittle:@"相机" image:@"tabbar_compose_shooting"];
        [self.btnView addSubview:_cameraBtn];
    }
    return _cameraBtn;
}
/**
 *  签到
 *
 */
- (UIButton *)signBtn
{
    if (!_signBtn) {
        self.signBtn = [[UIButton alloc] init];
        _signBtn = [self btnWithTittle:@"签到" image:@"tabbar_compose_lbs"];
        [self.btnView addSubview:_signBtn];
        
    }
    return _signBtn;
}
/**
 *  点评
 *
 */
- (UIButton *)reviewBtn
{
    if (!_reviewBtn) {
        self.reviewBtn = [[UIButton alloc] init];
        _reviewBtn = [self btnWithTittle:@"点评" image:@"tabbar_compose_review"];
        [self.btnView addSubview:_reviewBtn];
        
    }
    return _reviewBtn;
}
/**
 *  更多
 *
 */
- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        self.moreBtn = [[UIButton alloc] init];
        _moreBtn = [self btnWithTittle:@"更多" image:@"tabbar_compose_more"];
        
        [self.btnView addSubview:_moreBtn];
    }
    return _moreBtn;
}
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor =  JYColor(240, 240, 240);
    }
    return self;
}
+(instancetype)addView{
    
    return [[self alloc]init];
}

-(void)show{
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.imageView.centerX = self.width/2;
    self.imageView.y = 80;
    
    self.btnView.x = 0;
    self.btnView.y = [UIScreen mainScreen].bounds.size.height;
    self.btnView.width = self.width;
    self.btnView.height = 250;
    [UIView animateWithDuration:0.3 animations:^{
        self.btnView.centerY = self.height/2;
    }];
   
    //底部View
    self.bottomView.x = 0;
    self.bottomView.y = self.height-60;
    self.bottomView.height = 40;
    self.bottomView.width = self.width;
    //XX
    self.Ximage.centerY = 10;
    self.Ximage.width = 20;
    self.Ximage.height = 20;
    self.Ximage.centerX = self.bottomView.width/2;

    //文字
    self.textBtn.x = JYBtnBordeWide;
    self.textBtn.y = JYBtnBordeHeight;
    self.textBtn.width = JYBtnWidth;
    self.textBtn.height = JYBtnHeight;
    //相册
    self.albumBtn.x = CGRectGetMaxX(self.textBtn.frame)+JYBtnBorde;
    self.albumBtn.y = JYBtnBordeHeight;
    self.albumBtn.width = JYBtnWidth;
    self.albumBtn.height = JYBtnHeight;
    //照相
    self.cameraBtn.x = CGRectGetMaxX(self.albumBtn.frame)+JYBtnBorde;
    self.cameraBtn.y = JYBtnBordeHeight;
    self.cameraBtn.width = JYBtnWidth;
    self.cameraBtn.height = JYBtnHeight;
    //签到
    self.signBtn.x = JYBtnBordeWide;
    self.signBtn.y = CGRectGetMaxY(self.albumBtn.frame)+JYBtnBordeH;
    self.signBtn.width = JYBtnWidth;
    self.signBtn.height = JYBtnHeight;
    //点评
    self.reviewBtn.x = CGRectGetMaxX(self.signBtn.frame)+JYBtnBorde;
    self.reviewBtn.y = self.signBtn.y;
    self.reviewBtn.width = JYBtnWidth;
    self.reviewBtn.height = JYBtnHeight;
    //更多
    self.moreBtn.x = CGRectGetMaxX(self.reviewBtn.frame)+JYBtnBorde;
    self.moreBtn.y = self.signBtn.y;
    self.moreBtn.width = JYBtnWidth;
    self.moreBtn.height = JYBtnHeight;
    
}
//点击发送按钮
-(void)editorText:(UIButton *)buttnon{
    if ([self.delegate respondsToSelector:@selector(editorText:)]) {
        [self.delegate editorText:buttnon];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
-(void)dismiss{

    [UIView animateWithDuration:0.3 animations:^{
        self.btnView.y = 568;

    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];
}
@end
