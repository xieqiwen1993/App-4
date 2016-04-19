//
//  TabBarViewController.m
//  TXSLiCai
//
//  Created by huangkai on 15/10/12.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import "TabBarViewController.h"
#import "LifeViewController.h"
#import "FindViewController.h"
#import "MyViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self creatViewController];
    
    //设置导航栏为白色
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.tabBar.hidden=YES;
    
    [self creatMyTabBar];
    
    //    [btnTimeSession setImageEdgeInsets:UIEdgeInsetsMake(-12, 0, 12, 0)];
    //    [btnTimeSession setTitleEdgeInsets:UIEdgeInsetsMake(25, -95, -25, -48)];
}

//创建TabBar控制视图
-(void)creatViewController{
    //UIViewController *vc1=[[UIViewController alloc]init];
    
    NSArray *controllerArr=@[@"LifeViewController",@"FindViewController",@"MyViewController"];//WelfarePageViewController MainWelfarePage
    NSArray *vcName=@[@"悦生活",@"扫码",@"我的"];
    NSMutableArray *vcArr=[[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < controllerArr.count; i++) {
        
        Class vcClass = NSClassFromString(controllerArr[i]);
        //vcClass 创建对象
        UIViewController *vc = [[vcClass alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        //导航标题
        if (i==0) {
            vc.navigationItem.title=@"悦生活";
        }else{
            vc.navigationItem.title = vcName[i];
            
        }
        //标签栏标题
        nav.tabBarItem.title = vcName[i];
        nav.navigationBar.barTintColor=[UIColor whiteColor];
        //更改导航栏里的字符串颜色
        [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
        //  nav.navigationBar set
        NSString *name = [NSString stringWithFormat:@"tab_%ld",(long)i];
        //设置图片
        nav.tabBarItem.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
        NSString *selectName = [NSString stringWithFormat:@"tab_%ld",(long)i];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //放入数组
        [vcArr addObject:nav];
        
    }
    
    //把数组给tabBarController
    self.viewControllers = vcArr;
}

#pragma mark - 定制tabBar
- (void)creatMyTabBar {
    
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    delegate.myTabar=[[UIImageView alloc] initWithFrame:CGRectMake(0, BOUND_H(self.view)-64, BOUND_W(self.view), 64)];
    delegate.myTabar.image=[UIImage imageNamed:@"tabBg.jpg"];
    delegate.myTabar.backgroundColor=[UIColor whiteColor];
    delegate.myTabar.userInteractionEnabled = YES;
    delegate.myTabar.tag=101;
    [self.view addSubview:delegate.myTabar];
    NSArray *titles = @[@"悦生活",@"扫码",@"我的"];
    //标签栏的标签 大小 30*30
    CGFloat space = (BOUND_W(self.view)-23*3)/3;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(space/2+(23+space)*i, 16, 30, 30);
//        if (i==2) {
//            
//            button.frame= CGRectMake(space/2+(23+space)*i-13, 5,50, 50);
//            if (BOUND_W(self.view)==320) {
//                button.frame= CGRectMake(space/2+(23+space)*i-10.5, 10,45, 45);
//            }
//            
//        }
        
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_%ld",(long)i]] forState:UIControlStateNormal];
//        //选中
//        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_c%ld",i]] forState:UIControlStateSelected];
        button.userInteractionEnabled=NO;
        button.tag = 201+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [delegate.myTabar addSubview:button];
        //粘贴label
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, 50, button.frame.size.width, 14)];
        label.backgroundColor = [UIColor clearColor];
        label.text = titles[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        
        label.textColor = [UIColor colorWithRed:0.66 green:0.67 blue:0.67 alpha:1];
        if (i==0) {
            label.textColor=[UIColor redColor];
        }
        label.tag = 301+i;
        [delegate.myTabar addSubview:label];
        
//        if (i==2) {
//            [self btnAnimation];
//        }
        //最顶层的Button
        
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bgBtn.frame = CGRectMake(space/2+(23+space)*i, 23, 30, 30);
//        if (i==1) {
//            
//            bgBtn.frame= CGRectMake(space/2+(23+space)*i-13, 5,50, 50);
//            if (BOUND_W(self.view)==320) {
//                bgBtn.frame= CGRectMake(space/2+(23+space)*i-10.5, 10,45, 45);
//            }
//            
//        }
        bgBtn.tag=401+i;
        [bgBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        bgBtn.backgroundColor=[UIColor clearColor];
        [delegate.myTabar addSubview:bgBtn];
        
    }
    
    UIButton *button = (UIButton *)[self.view viewWithTag:401];
    button.selected = YES;//第0个按钮默认选中
    [self indexBtnImage:0];
}
-(void)btnAnimation{
    CGFloat space = (BOUND_W(self.view)-23*5)/6;
    NSInteger i=2;
    UIButton *button = (UIButton *)[self.view viewWithTag:203];
    
    if (BOUND_W(self.view)==320) {
        [UIView animateWithDuration:0.3 animations:^{
            button.frame= CGRectMake(space+(23+space)*i-10.5, 7,45, 45);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                button.frame= CGRectMake(space+(23+space)*i-10.5, 10,45, 45);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    button.frame= CGRectMake(space+(23+space)*i-10.5, 7,45, 45);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        button.frame= CGRectMake(space+(23+space)*i-10.5, 10,45, 45);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.3 animations:^{
                            button.frame= CGRectMake(space+(23+space)*i-10.5, 7,45, 45);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.1 animations:^{
                                button.frame= CGRectMake(space+(23+space)*i-10.5, 10,45, 45);
                            } completion:^(BOOL finished) {
                                
                            }];
                            
                        }];
                        
                    }];
                    
                }];
                
            }];
            
        }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            button.frame= CGRectMake(space+(23+space)*i-13, 2,50, 50);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                button.frame= CGRectMake(space+(23+space)*i-13,5,50, 50);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    button.frame= CGRectMake(space+(23+space)*i-13, 2,50, 50);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        button.frame= CGRectMake(space+(23+space)*i-13, 5,50, 50);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.3 animations:^{
                            button.frame= CGRectMake(space+(23+space)*i-13, 2,50, 50);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.1 animations:^{
                                button.frame= CGRectMake(space+(23+space)*i-13, 5,50, 50);
                            } completion:^(BOOL finished) {
                                
                            }];
                            
                        }];
                        
                    }];
                    
                }];
                
            }];
            
        }];
    }
    
    
}

-(void)indexBtnImage:(NSInteger)index{
    
    UIButton *button=(UIButton *)[self.view viewWithTag:401+index];
    //通过button 修改 tabBarController的selectedIndex 就可以切换界面
     // NSInteger index = button.tag-201;
    self.selectedIndex = index;
    button.selected = YES;//设置选中
    for (NSInteger i=0; i<3; i++) {
        UIButton *button=(UIButton *)[self.view viewWithTag:201+i];
        UILabel *label=(UILabel *)[self.view viewWithTag:301+i];
        if (i!=index) {
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_%ld",(long)i]] forState:UIControlStateNormal];
            
            label.textColor = [UIColor colorWithRed:0.66 green:0.67 blue:0.67 alpha:1];
        }else{
            
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_c%ld",(long)i]] forState:UIControlStateNormal];
            label.textColor= label.textColor=[UIColor redColor];
        }
    }
    
    
    UIImageView *myTabBar = (UIImageView *)[self.view viewWithTag:401];
    //让其他按钮设置 非选中
    for (UIView *view in myTabBar.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            //判断是否是uibutton
            if (view.tag != button.tag) {
                UIButton *newButton = (UIButton *)view;
                newButton.selected =  NO;
            }
        }
    }
    
    
}



- (void)btnClick:(UIButton *)button {
    //[self btnAnimation];
    //通过button 修改 tabBarController的selectedIndex 就可以切换界面
    NSInteger index = button.tag-401;
    self.selectedIndex = index;
    button.selected = YES;//设置选中
    for (NSInteger i=0; i<3; i++) {
        UIButton *button=(UIButton *)[self.view viewWithTag:201+i];
        UILabel *label=(UILabel *)[self.view viewWithTag:301+i];
        if (i!=index) {
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_%ld",(long)i]] forState:UIControlStateNormal];
            
            label.textColor = [UIColor colorWithRed:0.66 green:0.67 blue:0.67 alpha:1];
        }else{
            
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_c%ld",(long)i]] forState:UIControlStateNormal];
            label.textColor=[UIColor redColor];
        }
    }
    
    
    UIImageView *myTabBar = (UIImageView *)[self.view viewWithTag:401];
    //让其他按钮设置 非选中
    for (UIView *view in myTabBar.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            //判断是否是uibutton
            if (view.tag != button.tag) {
                UIButton *newButton = (UIButton *)view;
                newButton.selected =  NO;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
