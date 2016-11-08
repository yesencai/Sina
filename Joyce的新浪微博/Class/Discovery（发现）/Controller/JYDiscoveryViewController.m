//
//  DiscoveryViewController.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/16.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYDiscoveryViewController.h"
#import "JYSearchBar.h"
#import "UIView+Extension.h"
@implementation JYDiscoveryViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    //搜索框
    JYSearchBar *searchBar = [JYSearchBar searchBar];
    searchBar.width=300;
    searchBar.height=35;
    self.navigationItem.titleView = searchBar;
}
@end
