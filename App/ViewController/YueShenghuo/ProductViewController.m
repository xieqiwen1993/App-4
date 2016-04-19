//
//  ProductViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/12.
//  Copyright © 2016年 company. All rights reserved.
//

#import "ProductViewController.h"
#import "ApplicationViewController.h"
#import "ShangpinDaiViewController.h"
#import "XianjinDaiViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController
-(void)viewWillAppear:(BOOL)animated{
    //即将出现时隐藏tabbar
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    delegate.myTabar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"贷款产品";

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

- (IBAction)tryClick:(id)sender {
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==500) {
        //商品贷
        ShangpinDaiViewController *vc=[[ShangpinDaiViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        XianjinDaiViewController *vc=[[XianjinDaiViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
//    ApplicationViewController *vc=[[ApplicationViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}
@end
