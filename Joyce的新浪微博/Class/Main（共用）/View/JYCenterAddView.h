//
//  JYCenterAddView.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/23.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JYCenterAddViewDelegate <NSObject>

-(void)editorText:(UIButton *)buttnon;
@end

@interface JYCenterAddView : UIView
@property(nonatomic,assign)id <JYCenterAddViewDelegate>delegate;

+(instancetype)addView;

-(void)show;

-(void)dismiss;
@end
