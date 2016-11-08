//
//  MeViewController.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/16.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYMeViewController.h"
#import "JYAboutMeCell.h"
#import "JYUserInfo.h"
#import "MJExtension.h"
#import "JYAccountTool.h"
@interface JYMeViewController()
@property(nonatomic,strong)NSArray *imageArray;

@property(nonatomic,strong)NSArray *listArray;

/**
 *  存放用户信息
 */
@property(nonatomic,strong)NSMutableArray *userInfoArray;

@end

@implementation JYMeViewController
- (NSArray *)imageArray
{
    if (!_imageArray) {
        self.imageArray = [[NSArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",nil];
    }
    return _imageArray;
}
//懒加载
- (NSArray *)listArray
{
    if (!_listArray) {
        self.listArray = [[NSArray alloc] initWithObjects:@"我的好友",@"微博等级",@"我的相册",@"我的点评",@"我的赞",@"微博支付",@"微博运动",@"个性化",@"草稿箱",@"更多",nil];
    }
    return _listArray;
}
/**
 *  用户信息
 *
 */
- (NSArray *)userInfoArray
{
    if (!_userInfoArray) {
        self.userInfoArray = [[NSMutableArray alloc] init];
    }
    return _userInfoArray;
}
-(void)viewDidLoad{
    
    [super viewDidLoad];

    self.tableView.backgroundColor = JYColor(211, 211, 211);

    //获取用户信息
    [self getUserInfo];
    //右上角的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
}
-(void)getUserInfo{
    
    JYAccount *account = [JYAccountTool account];
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"access_token"] =account.access_token;
    parame[@"uid"] = account.uid;
    
    [JYHttpTool getPath:JYgetUserInfo parameters:parame success:^(id responseObject){
        
      JYUserInfo *userInfo = [JYUserInfo objectWithKeyValues:responseObject];
        JYUserInfoFrame *infoF = [[JYUserInfoFrame alloc]init];
        infoF.userInfo = userInfo;
        
        [self.userInfoArray addObject:infoF];
        [self.userInfoArray addObjectsFromArray:self.listArray];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.userInfoArray addObjectsFromArray:self.listArray];
        [self.tableView reloadData];
    }];
}
/**
 *  设置
 */
-(void)setting{
    
}
#pragma mark-TableViewDalegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
        JYUserInfoFrame *userInfoFrame = self.userInfoArray[indexPath.row];
        if ([userInfoFrame isKindOfClass:[JYUserInfoFrame class]]) {
            return userInfoFrame.cellHeight;
        }
    }
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.userInfoArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYAboutMeCell *aboutMe = [JYAboutMeCell cellWithTableView:tableView];
    if (self.userInfoArray.count==11&&indexPath.row==0){
        aboutMe.userInfoFrame = self.userInfoArray[indexPath.row];
    }else{
        aboutMe.textLabel.text = self.userInfoArray[indexPath.row];
        aboutMe.imageView.image =[UIImage imageNamed:@"lottery"];
    }
    return aboutMe;
}
@end
