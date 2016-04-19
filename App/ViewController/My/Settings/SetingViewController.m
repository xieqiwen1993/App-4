//
//  SetingViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/13.
//  Copyright © 2016年 company. All rights reserved.
//

#import "SetingViewController.h"
#import "AboutViewController.h"
@interface SetingViewController ()

@end

@implementation SetingViewController
-(void)viewWillAppear:(BOOL)animated{
    //即将出现时隐藏tabbar
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    delegate.myTabar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"设置";

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

- (IBAction)aboutClick:(id)sender {
    AboutViewController *vc=[[AboutViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)quitClick:(id)sender {
    
    BVTAlertView *alertView = [[BVTAlertView alloc] init];
    //alertView.delegate = blockify(self); // 这里用blockify(self)避免循环引用
    alertView.delegate=self;
    alertView.title = @"";
    alertView.message = @"退出当前账户？";
    alertView.cancelButtonTitle = @"取消";
    alertView.otherButtonTitles = @[@"确定"];
    alertView.cancelHandler = ^{
        NSLog(@"点击取消了");
    };
    alertView.dismissHandler = ^(NSUInteger index) {
        if (index == 0) {
            NSLog(@"点击确定");
        }
    };
    [alertView show];

}
@end
