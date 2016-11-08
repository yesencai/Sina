//
//  JYStatusePhotosView.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/17.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYStatusePhotosView.h"
#import "JYStatusePhotoImageView.h"
#import "JYPhoto.h"
#import "UIImageView+WebCache.h"
#define HWStatusPhotoWH 76
#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) ((count==4)?2:3)

@interface JYStatusePhotosView()

@end
@implementation JYStatusePhotosView
+(instancetype)statuse{
    
    static JYStatusePhotosView *photos = nil;
    if (!photos) {
        photos = [[self alloc]init];
    }
    return photos;
}
/**
 *  根据图片个数判断
 *
 *  @param count 图片个数
 *
 */
-(CGSize)sizeWithCount:(NSInteger)count url:(NSArray *)url{
    
    // CGFloat maxPhotoW = [UIScreen mainScreen].bounds.size.width+20;
    // 最大列数（一行最多有多少列）
    NSInteger maxCols = HWStatusPhotoMaxCol(count);
    NSInteger cols = (count >= maxCols)? maxCols : count;
    NSInteger rows = (count + maxCols - 1) / maxCols;
    
    CGFloat photosW =0;
    CGFloat photosH =0;
    
    photosW  = cols * HWStatusPhotoWH + (cols - 1) * HWStatusPhotoMargin;
    // 行数
    photosH = rows * HWStatusPhotoWH + (rows - 1) * HWStatusPhotoMargin;
    return CGSizeMake(photosW, photosH);
}
-(void)setPhotosArray:(NSArray *)photosArray{
    _photosArray = photosArray;
    
    int photosCount = (int)photosArray.count;
    while (self.subviews.count < photosCount) {
        JYStatusePhotoImageView *photoView = [[JYStatusePhotoImageView alloc] init];
        [self addSubview:photoView];
    }
    for (int i=0; i<self.subviews.count; i++) {
        JYStatusePhotoImageView *photoView =self.subviews[i];
        if (i<photosCount) {
            photoView.photo = photosArray[i];
            photoView.hidden = NO;
        }else{
            photoView.hidden = YES;
        }
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    int photosCount = (int)self.photosArray.count;
    int maxCol = HWStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        JYStatusePhotoImageView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (HWStatusPhotoWH + HWStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (HWStatusPhotoWH + HWStatusPhotoMargin);
        photoView.width = HWStatusPhotoWH;
        photoView.height = HWStatusPhotoWH;
        
        
    }
}
@end
