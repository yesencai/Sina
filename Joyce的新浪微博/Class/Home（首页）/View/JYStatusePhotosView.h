//
//  JYStatusePhotosView.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/17.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYStatusePhotosView : UIView

@property(nonatomic,strong)NSArray *photosArray;
+(instancetype)statuse;
/**
 *  更加图片个数判断整个配图的宽高
 *
 *  @param count 图片个数
 *
 */
-(CGSize)sizeWithCount:(NSInteger)count url:(NSArray *)url;
@end
