//
//  GuidViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/8.
//  Copyright © 2016年 company. All rights reserved.
//

#import "GuidViewController.h"
#import "TabBarViewController.h"
@interface GuidViewController ()<UIScrollViewDelegate>

@end

@implementation GuidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];

    [self initGuide];   //加载新用户指导页面

}
- (void)initGuide
 {
     NSInteger heght=self.view.frame.size.height;
     NSInteger wight=self.view.frame.size.width;

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, wight, heght)];
    [scrollView setContentSize:CGSizeMake(wight*4, 0)];
    [scrollView setPagingEnabled:YES];  //视图整页显示
    //    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    
         UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,wight , heght)];
         [imageview setImage:[UIImage imageNamed:@"引导页1（640x1136）"]];
         [scrollView addSubview:imageview];
    
         UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(wight, 0, wight, heght)];
         [imageview1 setImage:[UIImage imageNamed:@"引导页2（640x1136）"]];
         [scrollView addSubview:imageview1];
     
         UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(wight*2, 0, wight, heght)];
        [imageview2 setImage:[UIImage imageNamed:@"引导页3（640x1136）"]];
         [scrollView addSubview:imageview2];
     
        UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(wight*3, 0, wight, heght)];
          [imageview3 setImage:[UIImage imageNamed:@"（640x1136）"]];
          imageview3.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
          [scrollView addSubview:imageview3];
     
     
          UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
          [button setTitle:nil forState:UIControlStateNormal];
          [button setFrame:CGRectMake(0, 0, imageview3.frame.size.width, imageview3.frame.size.height)];
          [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
          [imageview3 addSubview:button];
     
          [self.view addSubview:scrollView];
     }
- (void)firstpressed
 {
       [self presentViewController:[TabBarViewController alloc] animated:YES completion:^{
           
       }];
//     TabBarViewController *tab=[[TabBarViewController alloc]init];
//     [self.navigationController pushViewController:tab animated:YES];
//     //点击button跳转到根视图

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
