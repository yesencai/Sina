//
//  MessageViewController.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/5/16.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//
#import "JYMessageViewController.h"
#import "textView.h"
@implementation JYMessageViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //右上角的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发起聊天" style:UIBarButtonItemStylePlain target:self action:@selector(chat)];

}
/**
 *发起聊天
 */
-(void)chat{
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    textView *tt = [[textView alloc]init];
    [self.navigationController pushViewController:tt animated:YES];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID
                ];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test-Message-%lu",(long)indexPath.row];
    return cell;
}

@end
