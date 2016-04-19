//
//  SetPasswordViewController.m
//  TXSLiCai
//
//  Created by homer on 15/10/17.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "PwdView.h"
#import "TangXSSingleton.h"

@interface SetPasswordViewController ()
{
    PwdView *passwordView;
}
@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    
    passwordView = [[PwdView alloc]initWithFrame:CGRectMake(0, 0, BOUND_W(self.view) , BOUND_H(self.view))];
    [passwordView showWithPush:^(NSString *passwordText) {
        
        NSLog(@"密码输入完成");
        
    }];
    [passwordView showWithPop:^(NSString *passwordText) {
        
        [self.navigationController popViewControllerAnimated:YES];
        [[TangXSSingleton sharedInstance].arrTempViewController removeLastObject];
        
    }];
    [self.view addSubview:passwordView];
    
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
