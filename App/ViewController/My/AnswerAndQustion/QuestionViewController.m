//
//  QuestionViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/13.
//  Copyright © 2016年 company. All rights reserved.
//

#import "QuestionViewController.h"
#import "ProcessViewController.h"
#import "UsualViewController.h"
#import "PaymentViewController.h"
@interface QuestionViewController ()<BVTLoadingViewDelegate>

@end

@implementation QuestionViewController

-(void)viewWillAppear:(BOOL)animated{
    //即将出现时隐藏tabbar
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    delegate.myTabar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"自助答疑";
    
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

- (IBAction)firstClick:(id)sender {
    ProcessViewController *vc=[[ProcessViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)secondClick:(id)sender {
      PaymentViewController *vc=[[PaymentViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)thirdClick:(id)sender {
    UsualViewController *vc=[[UsualViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)forthClick:(id)sender {
    
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
@end
