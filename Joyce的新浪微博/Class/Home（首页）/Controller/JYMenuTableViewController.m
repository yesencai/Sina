//
//  JYMenuTableViewController.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/23.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYMenuTableViewController.h"

@implementation JYMenuTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
}
//每个section里面拥有多少个row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row==0) {
        cell.textLabel.text=@"好朋友";
    }else if (indexPath.row==1){
        cell.textLabel.text=@"恋人";

    }else if (indexPath.row==2){
        cell.textLabel.text=@"基友";

    }else if (indexPath.row==3){
        cell.textLabel.text=@"密友";

    }else if (indexPath.row==4){
        cell.textLabel.text=@"狗肉";

    }else if (indexPath.row==5){
        cell.textLabel.text=@"狗肉";
        
    }else if (indexPath.row==6){
        cell.textLabel.text=@"狗肉";
        
    }else if (indexPath.row==7){
        cell.textLabel.text=@"狗肉";
        
    }else if (indexPath.row==8){
        cell.textLabel.text=@"狗肉";
        
    }else if (indexPath.row==9){
        cell.textLabel.text=@"狗肉";
        
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
@end
