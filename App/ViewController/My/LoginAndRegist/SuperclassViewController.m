//
//  SuperclassViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/8.
//  Copyright © 2016年 company. All rights reserved.
//

#import "SuperclassViewController.h"

@interface SuperclassViewController ()

@end

@implementation SuperclassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)fristCreatAllView{
    self.safeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.safeBtn setTitleColor:[UIColor colorWithRed:0.92 green:0.17 blue:0 alpha:1] forState:UIControlStateNormal];
    [self.safeBtn setImage:[UIImage imageNamed:@"红色的.jpg"] forState:UIControlStateNormal];
    [self.safeBtn setTitle:@"" forState:UIControlStateNormal];
    self.safeBtn.frame=CGRectMake(0, 1055*kHeightRatioFrame, kScreenWidth, 50*kHeightRatio);
    self.safeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:self.safeBtn];
    
    self.secureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.secureBtn setTitle:@" " forState:UIControlStateNormal];
    [self.secureBtn setTitleColor:[UIColor colorWithRed:0.62 green:0.64 blue:0.65 alpha:1] forState:UIControlStateNormal];
    [self.secureBtn setImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    self.secureBtn.frame=CGRectMake(0,1800*kHeightRatioFrame, kScreenWidth,40*kHeightRatio);
    self.secureBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:self.secureBtn];
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
