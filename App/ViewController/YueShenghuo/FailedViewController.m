//
//  FailedViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/13.
//  Copyright © 2016年 company. All rights reserved.
//

#import "FailedViewController.h"
#import "LifeViewController.h"

@interface FailedViewController ()

@end

@implementation FailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)resubmitClick:(id)sender {
    //重新提交
    
}

- (IBAction)contactClick:(id)sender{
    //联系客服
    BVTAlertView *alertView = [[BVTAlertView alloc] init];
    //alertView.delegate = blockify(self); // 这里用blockify(self)避免循环引用
    alertView.delegate=self;
    alertView.title = @"";
    alertView.message = @"028-08234597234";
    alertView.cancelButtonTitle = @"取消";
    alertView.otherButtonTitles = @[@"拨打"];
    alertView.cancelHandler = ^{
        NSLog(@"点击取消了");
    };
    alertView.dismissHandler = ^(NSUInteger index) {
        if (index == 0) {
            NSLog(@"点击b拨打电话了");
        }
    };
    [alertView show];

}

- (IBAction)returnRootClick:(id)sender {
    
    
  //返回首页
    [ToolMethod pushNewView:self pushIndex:0];
    
    
    
}
@end
