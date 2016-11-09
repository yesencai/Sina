//
//  HomeViewController.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/16.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYHomeViewController.h"
#import "UIBarButtonItem+Tool.h"
#import "JYAccountTool.h"
#import "JYDropdownMenu.h"
#import "JYTittleButton.h"
#import "JYMenuTableViewController.h"
#import "UIImageView+WebCache.h"
#import "JYStatuses.h"
#import "JYUser.h"
#import "MJExtension.h"
#import "JYLoadMoreFooter.h"
#import "JYStatuseFrame.h"
#import "JYStatuseCell.h"
#import "MLMusicViewController.h"
@interface JYHomeViewController()<JYDropdownMenuDelegate>
/**
 *  微博数组（里面存放JYStatuseFrame模型）
 */
@property(nonatomic,strong)NSMutableArray *statusesFrame;
@end

@implementation JYHomeViewController

-(NSMutableArray *)statusesFrame{
    if(!_statusesFrame){
        self.statusesFrame = [NSMutableArray array];
    }
    return _statusesFrame;
}
-(void)viewDidLoad{
    
    [super viewDidLoad];
    
     self.tableView.backgroundColor = JYColor(211, 211, 211);
    //设置导航栏
    [self setNavigation];
    //获取用户信息
    [self getUserInfo];

    //[self getNewStatus];
    //下拉刷新
    [self refreshDownNewStatus];
   
    //上拉加载更多
    [self refreshUpNewStatus];
    
    //获取未读微博条数
    // 获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
/**
 *  上啦加载更多
 */
-(void)refreshUpNewStatus{
    JYLoadMoreFooter *footer = [JYLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}
/**
 *  显示微博数量
 *
 *  @param count 数量
 */
-(void)showNewStatusCount:(NSInteger)count{
    
    UILabel *lable = [[UILabel alloc]init];
    lable.width = [UIScreen mainScreen].bounds.size.width;
    lable.height = 30;
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:16];
    lable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    lable.y = 64 - lable.height;
    if (count==0) {
        lable.text = @"没有新微博";
    }else{
        lable.text = [NSString stringWithFormat:@"%ld条新微博",(long)count];
    }
    [self.navigationController.view insertSubview:lable belowSubview:self.navigationController.navigationBar];
    
    [UIView  animateWithDuration:0.5 animations:^{
        lable.transform = CGAffineTransformMakeTranslation(0, lable.height);
        
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.5 delay:1.0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            lable.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [lable removeFromSuperview];
        }];
        
    }];

}
/**
 *  获取未读微博数量
 */
-(void)setupUnreadCount{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    JYAccount *account = [JYAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [JYHttpTool getPath:JYgetStatusesUnreadCount parameters:params success:^(id responseObject) {
        NSString *status = [responseObject[@"status"] description];
        if (status.intValue==0) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.integerValue;
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}
/**
 *  下拉刷新
 */
-(void)refreshDownNewStatus{

    UIRefreshControl *refresh =[[UIRefreshControl alloc]init];
    [self.tableView addSubview:refresh];
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self refresh:refresh];
    [refresh beginRefreshing];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusesFrame.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}
-(NSArray *)statuseFrameWithStatuse:(NSArray *)statuses{
    
    NSMutableArray *newFrame = [NSMutableArray array];
    for (JYStatuses *status in statuses) {
        JYStatuseFrame *f = [[JYStatuseFrame alloc]init];
        f.statuse = status;
        [newFrame addObject:f];
    }
    return newFrame;
}
/**
 *  上拉获取更多微博
 */
-(void)loadMoreStatus{
    
    JYAccount *account = [JYAccountTool account];
    NSMutableDictionary *paramet = [NSMutableDictionary dictionary];
    paramet[@"access_token"] =account.access_token;
    JYStatuseFrame *statusesFrame = [self.statusesFrame lastObject];
    if (statusesFrame) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = statusesFrame.statuse.idstr.longLongValue - 1;
        paramet[@"max_id"] = @(maxId);
    }
    [JYHttpTool getPath:JYgetStatusesFriendsTimeline parameters:paramet success:^(id responseObject) {
        //结束刷新
        NSArray *array = [JYStatuses objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newFrame = [self statuseFrameWithStatuse:array];
        
        [self.statusesFrame addObjectsFromArray:newFrame];

        //刷新表格
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden = YES;

    } failure:^(NSError *error) {
        //结束刷新
        self.tableView.tableFooterView.hidden = NO;
    }];
    
}
/**
 *  刷新
 *
 *  @param control
 */
-(void)refresh:(UIRefreshControl *)control{
    
    JYAccount *account = [JYAccountTool account];
    NSMutableDictionary *paramet = [NSMutableDictionary dictionary];
    paramet[@"access_token"] =account.access_token;
    JYStatuseFrame *statuseFrame = [self.statusesFrame firstObject];
    if (statuseFrame) {
        paramet[@"since_id"] = statuseFrame.statuse.idstr;
    }
    [JYHttpTool getPath:JYgetStatusesFriendsTimeline parameters:paramet success:^(id responseObject) {
        //结束刷新
        [control endRefreshing];
        NSArray *array = [JYStatuses objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSArray *newFrame = [self statuseFrameWithStatuse:array];
        [self.statusesFrame insertObjects:newFrame atIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, newFrame.count)]];
        self.tabBarItem.badgeValue = nil;
        //显示刷新微博的数量
        [self showNewStatusCount:array.count];
        //刷新表格
        [self.tableView reloadData];
        [MBProgressHUD hideHUD];

    } failure:^(NSError *error) {
        //结束刷新
        [control endRefreshing];
        [MBProgressHUD showSuccess:@"请求失败"];
    }];
}
/**
 *  获取最新的微博数据
 */
-(void)getNewStatus{
    
    JYAccount *account = [JYAccountTool account];
    NSDictionary *paramet = @{@"access_token":account.access_token};
    
    [JYHttpTool getPath:JYgetStatusesFriendsTimeline parameters:paramet success:^(id responseObject) {
        NSArray *array = [JYStatuses objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        [self.statusesFrame addObjectsFromArray:array];
        //刷新表格
        [self.tableView reloadData];
        [MBProgressHUD showSuccess:@"获取成功"];

    } failure:^(NSError *error) {
        
        [MBProgressHUD showSuccess:@"网络异常"];

    }];
}
/**
 *  获取用户信息，昵称等。
 */
-(void)getUserInfo{
    
    JYAccount *account = [JYAccountTool account];
    NSMutableDictionary *pareme = [NSMutableDictionary dictionary];
    pareme[@"uid"] = account.uid;
    pareme[@"access_token"] = account.access_token;
    [JYHttpTool getPath:JYgetOAuthUserInfo parameters:pareme success:^(id responseObject) {
        JYUser *user = [JYUser objectWithKeyValues:responseObject];
        account.name = user.name;
        [JYAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        
        
    }];
}
/**
 *  设置导航栏
 */
-(void)setNavigation{
    
    //左边按钮
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithTarget:self acction:@selector(friendsearch) image:@"navigationbar_friendsearch" lightImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.leftBarButtonItem = leftItem;
    //右边按钮
    UIBarButtonItem *rightItem = [UIBarButtonItem ml_itemWithTarget:self acction:@selector(pop)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //中间首页按钮
    JYTittleButton *tittleBtn = [JYTittleButton button];
    JYAccount *account = [JYAccountTool account];
    NSString *name = account.name;
    //按钮的标题
    [tittleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    //按钮的点击事件
    [tittleBtn addTarget:self action:@selector(clickTittle:) forControlEvents:UIControlEventTouchUpInside];
    //把按钮添加到导航栏上
    self.navigationItem.titleView = tittleBtn;

}
/**
 *  点击标题按钮
 */
-(void)clickTittle:(UIButton *)tittleBtn{
    //初始化下拉菜单
    JYDropdownMenu *menu = [JYDropdownMenu menu];
    JYMenuTableViewController *vc = [[JYMenuTableViewController alloc]init];
    menu.delegate = self;
    vc.view.height = 44*6;
    vc.view.width  = 150;
    menu.contentController = vc;
    
    //显示下拉菜单
    [menu show:tittleBtn];
    
}
/**
 *  搜索好友
 */
-(void)friendsearch{
    
}
/**
 *  播放歌曲
 */
-(void)pop{
    MLMusicViewController *vc = [[MLMusicViewController alloc]init];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark-JYDropdownMenuDelegate-点击下拉菜单的代理方法
-(void)dropdownMenuClickShow:(JYDropdownMenu *)menu{
    UIButton *tittleButton = (UIButton *)self.navigationItem.titleView;
    tittleButton.selected = YES;
}
-(void)dropdownMenuClickDismiss:(JYDropdownMenu *)menu{
    UIButton *tittleButton = (UIButton *)self.navigationItem.titleView;
    tittleButton.selected = NO;
}

#pragma mark-TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.statusesFrame.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYStatuseCell *cell = [JYStatuseCell cellWithTableView:tableView];
    cell.statusFrame = self.statusesFrame[indexPath.row];
    
    return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYStatuseFrame *statuseFrame = self.statusesFrame[indexPath.row];

    return statuseFrame.cellHeight;
}




@end
