//
//  SendStatusViewController.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/30.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYSendStatusViewController.h"
#import "JYAccountTool.h"
#import "JYAccount.h"
#import "JYTextView.h"
#import "JYSendStatusToolBar.h"
#define JYNSNotificationCenter [NSNotificationCenter defaultCenter]

@interface JYSendStatusViewController()<UITextViewDelegate,JYSendStatusToolBarDelegate>
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)JYSendStatusToolBar *toolBar;

@end
@implementation JYSendStatusViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    //设置取消、发送按钮
    [self setNavigation];
    //设置导航栏的标题
    [self setNaviTittle];
    //输入框TextView
    [self setTextView];
}
-(void)setTextView{
    
    JYTextView *textView = [JYTextView textView];
    self.textView= textView;
    textView.alwaysBounceVertical = YES;
    textView.font = [UIFont systemFontOfSize:16];
    textView.frame = self.view.bounds;
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    
    JYSendStatusToolBar *toolBar = [[JYSendStatusToolBar alloc]init];
    toolBar.delegate = self;
    toolBar.width = self.view.width;
    toolBar.height = 44;
    self.toolBar = toolBar;
    [self.view addSubview:toolBar];
    // 键盘通知
    // 键盘的frame发生改变时发出的通知（位置和尺寸）
    //    UIKeyboardWillChangeFrameNotification
    //    UIKeyboardDidChangeFrameNotification
    // 键盘显示时发出的通知
    //    UIKeyboardWillShowNotification
    //    UIKeyboardDidShowNotification
    // 键盘隐藏时发出的通知
    //    UIKeyboardWillHideNotification
    //    UIKeyboardDidHideNotification
   [ JYNSNotificationCenter addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)keyboardChange:(NSNotification *)notification{
    NSDictionary *info = notification.userInfo;
    /*
     {
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 441.5}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 694.5}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 315}, {320, 253}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 568}, {320, 253}}";
     }
     */
    CGRect endFrame = [info[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    double duration = [info[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (endFrame.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolBar.y = self.view.height - self.toolBar.height;
        } else {
            self.toolBar.y = endFrame.origin.y - self.toolBar.height;
        }
    }];
    
}
/**
 *  导航栏标题
 */
-(void)setNaviTittle{
    
    UILabel *tittlLable = [[UILabel alloc]init];
    tittlLable.width = self.view.width;
    tittlLable.height = 44;
    tittlLable.numberOfLines = 0;
    JYAccount *account = [JYAccountTool account];
    NSString *name = account.name;
    NSString *str = @"发微博";
    if (name) {
       NSString *tittleStr = [NSString stringWithFormat:@"%@\n%@",str,account.name];
        tittlLable.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = tittlLable;
        
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:tittleStr];
        [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[tittleStr rangeOfString:name]];
        [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[tittleStr rangeOfString:name]];
        tittlLable.attributedText = attributed;
    }else{
        self.navigationItem.title = str;
    }
   
}
/**
 *  取消、发送按钮
 */
-(void)setNavigation{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
}
//下拉关闭键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self.textView becomeFirstResponder];
}
/**
 *  取消发送微博
 */
-(void)cancel{
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送微博
 */
-(void)send{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JYAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    [MBProgressHUD showMessage:@"正在发送..."];
    // 3.发送请求
    [JYHttpTool postPath:JYSendStatuse parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"发送成功"];

    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"发送失败"];
    }];
}
#pragma mark-JYSendStatusToolBarDelegate
-(void)sendStatusWithToolBar:(JYSendStatusToolBar *)toolBar clickBtnType:(JYSendStatusToolbarButtonType)btnType{
    
    switch (btnType) {
        case JYSendStatusToolbarButtonTypeCamera://拍照
            [self openCamera];
            break;
        case JYSendStatusToolbarButtonTypePicture://相册
            
            break;
        case JYSendStatusToolbarButtonTypeMention://@
            
            break;
        case JYSendStatusToolbarButtonTypeTrend://#话题
            
            break;
        case JYSendStatusToolbarButtonTypeEmotion://表情、键盘
            
            break;

        default:
            break;
    }
}
-(void)openCamera{
    
}
-(void)dealloc{

    [JYNSNotificationCenter removeObserver:self];
}
@end
