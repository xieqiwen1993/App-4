//
//  XianjinDaiViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/19.
//  Copyright © 2016年 company. All rights reserved.
//

#import "XianjinDaiViewController.h"
#import "ApplicationViewController.h"

@interface XianjinDaiViewController ()<UIScrollViewDelegate>
{
    NSArray *_arr;
    NSArray *_arr1;
}
@property(nonatomic,strong)UIView * toastView;
@property(nonatomic,strong)UIView * toastView1;


@end

@implementation XianjinDaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"现金贷";

    // Do any additional setup after loading the view from its nib.
}
//日期toast
-(void)makeToastWithArr:(NSArray *)titleArr andStr:(NSString*)str{
    
    self.toastView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.toastView.backgroundColor=[UIColor darkGrayColor];
    self.toastView.alpha=0.8;
    
    [self.view addSubview:self.toastView];
    //toast
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-250)/2, 200, 250, 200)];
    view1.backgroundColor=[UIColor whiteColor];
    view1.alpha=1;
    [self.toastView addSubview:view1];
    
    
    UILabel *lal=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, view1.frame.size.width, 45)];
    lal.backgroundColor=[UIColor orangeColor];
    lal.textAlignment=NSTextAlignmentCenter;
    lal.textColor=[UIColor whiteColor];
    lal.text=str;
    [view1 addSubview:lal];
    
    for (int i=0; i<3; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(0, 48+45*i, view1.frame.size.width, 40) ;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            btn.tag=500+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:btn];
        
        UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(20, btn.frame.origin.y+btn.frame.size.height+3, btn.frame.size.width-40, 1)];
        line.backgroundColor=[UIColor lightGrayColor];
        [view1 addSubview:line];
    }
    
    
}
//点击选择 日期
-(void)btnClick:(UIButton*)btn{
    //[btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    // 500 501 502
        //分期期限
        for (int i=500; i<503; i++) {
            
            if (btn.tag==i) {
                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                self.monthBtn.titleLabel.text=[_arr objectAtIndex:i-500] ;
                
            }else{
                
                UIButton *btn=(UIButton *)[self.view viewWithTag:i];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    
    
    self.toastView.hidden=YES;
    
    
}
//贷款金额toast
-(void)makeToast1WithArr:(NSArray *)titleArr andStr:(NSString*)str{
    
    self.toastView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.toastView.backgroundColor=[UIColor darkGrayColor];
    self.toastView.alpha=0.8;
    
    [self.view addSubview:self.toastView];
    //toast
    UIScrollView *view1=[[UIScrollView alloc]initWithFrame:CGRectMake((kScreenWidth-250)/2, 245, 250, 200)];
    view1.backgroundColor=[UIColor whiteColor];
    view1.alpha=1;
    view1.contentOffset=CGPointMake(0, 0);
    view1.contentSize =CGSizeMake(0, 300);
    [self.toastView addSubview:view1];
    
    //头部lable
    UILabel *lal=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-250)/2, 200, view1.frame.size.width, 45)];
    lal.backgroundColor=[UIColor orangeColor];
    lal.textAlignment=NSTextAlignmentCenter;
    lal.textColor=[UIColor whiteColor];
    lal.text=str;
    [self.toastView addSubview:lal];
    
    for (int i=0; i<5; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(0, 2+45*i, view1.frame.size.width, 40) ;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        btn.tag=600+i;
        [btn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:btn];
        
        UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(20, btn.frame.origin.y+btn.frame.size.height+3, btn.frame.size.width-40, 1)];
        line.backgroundColor=[UIColor lightGrayColor];
        [view1 addSubview:line];
    }
    
    
}
//点击选择 贷款金额
-(void)btnClick1:(UIButton*)btn{
    //[btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    // 500 501 502
    //分期期限
    for (int i=600; i<605; i++) {
        
        if (btn.tag==i) {
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            self.loanBtn.titleLabel.text=[_arr1 objectAtIndex:i-600] ;
            
        }else{
            
            UIButton *btn=(UIButton *)[self.view viewWithTag:i];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    
    self.toastView.hidden=YES;
    
    
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

- (IBAction)monthClick:(id)sender {
    //月份选择
    _arr=@[@"0个月",@"6个月",@"12个月"];
    [self makeToastWithArr:_arr andStr:@"分期期限"];
}

- (IBAction)loanClick:(id)sender {
    //贷款金额
    _arr1=@[@"1000",@"3000",@"5000",@"7000",@"9000"];
    [self makeToast1WithArr:_arr1 andStr:@"贷款金额"];

}

- (IBAction)beginClick:(id)sender {
    //开始试算
    ApplicationViewController *vc=[[ApplicationViewController alloc]init];
    vc.isfromVc=1;
    [self.navigationController pushViewController:vc animated:YES];

}

@end
