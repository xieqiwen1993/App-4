//
//  BaseViewController.m
//  TangXSLiCai
//
//  Created by homer on 15/6/5.
//  Copyright (c) 2015年 YXF. All rights reserved.
//

#import "BaseViewController.h"
#import "TabBarViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tabBarController.tabBar.hidden = YES;
    // Do any additional setup after loading the view.
}

#pragma mark - MBProgressHUD
//显示进度条
-(void)showProgress {
    // The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
    if(_HUD){
        [_HUD removeFromSuperview];
        _HUD = nil;
    }
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    
    // Show the HUD while the provided method executes in a new thread
    [_HUD show:YES];
}

//隐藏进度条
- (void)hideProgress {
    [_HUD hide:YES];
}

/**
 *  显示一则消息 自动隐藏
 */
- (void)showPropt:(NSString *)message {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

//在离开页面的时候隐藏进度条
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_HUD hide:YES];
}

/**
 *  显示错误消息
 *
 *  @param response     返回的数据
 *  @param otherMessage errorMsg为空时显示内容
 */
- (void)showErrorMsgWithResponse:(id)response OtherMsg:(NSString *)otherMessage{
    
    NSString *errorMsg = [NSString stringWithFormat:@"%@",[response objectForKey:@"errormsg"]];
    
    if ([response objectForKey:@"errorcode"] != [NSNull null] && [[response objectForKey:@"errorcode"] isEqualToString:@"missing_parameter_accountid"]) {
        [self showPropt:@"您本次登录已结束"];
        
        
//        AppDelegate *delegate=[UIApplication sharedApplication].delegate;
//        [delegate.myTabar removeFromSuperview];
//        TabBarViewController *tabBar=[[TabBarViewController alloc]init];
//        self.navigationController.navigationBar.hidden=YES;
//        self.tabBarController.tabBar.hidden=YES;
//        [tabBar indexBtnImage:0];
//        [self.navigationController pushViewController:tabBar animated:YES];
//        
        
        //[ToolMethod pushNewView:self pushIndex:0];
        
        //清除token等缓存
        //[ToolMethod clearDataWhenLogOut];
        
    } else if (![errorMsg isEqualToString:@"<null>"]){
        [self showPropt:errorMsg];
    } else {
        [self showPropt:otherMessage];
    }
}

/**
 *  显示错误消息
 *
 *  @param response     返回的数据
 *  @param otherMessage errorMsg为空时显示内容
 */
- (void)showErrorMsgWithResponse:(id)response OtherMsg:(NSString *)otherMessage IsShowOtherMsg:(BOOL)isShow{
    
    NSString *errorMsg = [NSString stringWithFormat:@"%@",[response objectForKey:@"errormsg"]];
    if ([[response objectForKey:@"errorcode"] isEqualToString:@"missing_parameter_accountid"]) {
        [self showPropt:@"您本次登录已结束"];
        
//        AppDelegate *delegate=[UIApplication sharedApplication].delegate;
//        [delegate.myTabar removeFromSuperview];
//        TabBarViewController *tabBar=[[TabBarViewController alloc]init];
//        self.navigationController.navigationBar.hidden=YES;
//        self.tabBarController.tabBar.hidden=YES;
//        [tabBar indexBtnImage:0];
//        [self.navigationController pushViewController:tabBar animated:YES];
        // [ToolMethod pushNewView:self pushIndex:0];
        
        //清除token等缓存
        //[ToolMethod clearDataWhenLogOut];
        
    } else if (![errorMsg isEqualToString:@"<null>"]){
        
        [self showPropt:errorMsg];
        
    } else {
        if (isShow) {
            [self showPropt:otherMessage];
        }
    }
}

//用于回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
