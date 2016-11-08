//
//  JYUserGuideViewController.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/24.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYUserGuideViewController.h"
#import "JYDefine.h"
#import "JYMainTabBarController.h"
#define JYScrollViewImageCount 4
@interface JYUserGuideViewController()<UIScrollViewDelegate>
@property(nonatomic,weak)UIPageControl *pageControl;

@end
@implementation JYUserGuideViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    //1.创建ScrollView ,显示所有图片
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    scrollView.delegate = self;
    for (int i =0; i<JYScrollViewImageCount; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i*scrollW;
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        if (i==JYScrollViewImageCount-1) {
            [self shareButton:imageView];
        }
    }
    //2.如果想让某个方向不能滚到，那么该方向直接传0
    scrollView.contentSize = CGSizeMake(scrollW*JYScrollViewImageCount, 0);
    //除掉弹簧效果
    scrollView.bounces = NO;
    //分页
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    //pageView
    UIPageControl *page = [[UIPageControl alloc]init];
    page.numberOfPages = JYScrollViewImageCount;
    page.centerX = scrollW/2;
    page.centerY = scrollH-50;
    //选中的颜色
    page.currentPageIndicatorTintColor = JYColor(253, 98, 42);
    //没有选中的颜色
    page.pageIndicatorTintColor = JYColor(189, 189, 189);
    self.pageControl = page;
    [self.view addSubview:page];
    
}
/**
 *  选择分享微博按钮和开始微博按钮
 *
 *  @param imageView 最后一个imageView
 */
-(void)shareButton:(UIImageView *)imageView{
    
    //选择分享微博按钮
    imageView.userInteractionEnabled =YES;
    UIButton *shareBtn = [[UIButton alloc]init];
    [shareBtn setTitle:@"分享到微博" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"]forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"]forState:UIControlStateSelected];
    shareBtn.width = 130;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width/2;
    shareBtn.centerY = imageView.height*0.65;
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [shareBtn addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
    //开始微博按钮
    UIButton *starBtn = [[UIButton alloc]init];
    starBtn.layer.cornerRadius = 5.0;
    starBtn.layer.masksToBounds = YES;
    starBtn.backgroundColor = [UIColor redColor];
    [starBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [starBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [starBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    starBtn.size =starBtn.currentBackgroundImage.size;
    starBtn.centerX = imageView.width/2;
    starBtn.centerY = imageView.height*0.75;
    [starBtn addTarget:self action:@selector(clickStar) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:starBtn];
}
/**
 *  是否分享微博按钮
 *
 *  @param button 分享微博按钮
 */
-(void)clickShare:(UIButton *)button{
    button.selected = !button.isSelected;
}
/**
 *  切换根视图
 */
-(void)clickStar{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[JYMainTabBarController alloc]init];
}
#pragma mark-scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
   double page = scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage = (int)(page+0.5);
}
@end
