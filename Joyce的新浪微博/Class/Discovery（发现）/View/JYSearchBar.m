//
//  JYSearchBar.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/17.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYSearchBar.h"
@implementation JYSearchBar

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:14];
        self.placeholder = @"搜索....";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];        
        //放大镜
        UIImageView *search = [[UIImageView alloc]init];
        search.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        search.width = 30;
        search.height = 30;
        search.contentMode = UIViewContentModeCenter;
        self.leftView = search;
        self.leftViewMode = UITextFieldViewModeUnlessEditing;

    }
    return self;
}
+(instancetype)searchBar{
    
    return [[self alloc] init];
}
@end
