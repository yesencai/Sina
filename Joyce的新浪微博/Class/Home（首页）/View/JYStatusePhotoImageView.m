//
//  JYStatusePhotoImageView.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/17.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYStatusePhotoImageView.h"
#import "UIImageView+WebCache.h"
@interface JYStatusePhotoImageView()
@property (nonatomic, weak) UIImageView *gifView;

@end
@implementation JYStatusePhotoImageView
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    
    if (self) {
        
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;

    }
    return self;
}
/**
 *  重写photo属性
 *
 *  @param photo 相册模型
 */
-(void)setPhoto:(JYPhoto *)photo{
    
    _photo = photo;
      [self sd_setImageWithURL:[NSURL URLWithString:self.photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
