//
//  MyLoanViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import "MyLoanViewController.h"
#import "MyLoanView.h"
#import "LoanDetailViewController.h"

@interface MyLoanViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *examples;
@property (nonatomic) CGFloat percentage;

@end

@implementation MyLoanViewController
-(void)viewWillAppear:(BOOL)animated{
    //即将出现时隐藏tabbar
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    delegate.myTabar.hidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"我的贷款";
    [self creatCircle];
    [self creatViews];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)creatViews{
    
    
    UIView *uperView=[[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight-200 , kScreenWidth, 200)];
    uperView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:uperView];
   
    
     // MyLoanView
    for (int i=1; i<5; i++) {
       // if (i==1) {
        NSInteger x=0;
        NSInteger y=0;
        
        if (i==1 || i==3) {
            x=2;
        }else{
            x=2+kScreenWidth/2;
        }
        if (i==1 ||i==2) {
            y=2;
        }else{
            y=2+100;
        }
        
        MyLoanView *lview=[MyLoanView instanceTextView];
        lview.frame=CGRectMake(x, y, kScreenWidth/2-2, 97);
        if (i==1) {
            lview.imgImageview.image=[UIImage imageNamed:@"总贷款金额"];
            lview.titleLable.text=@"总贷款金额";
            lview.detailLable.text=@"6000";
        }else if (i==2){
            lview.imgImageview.image=[UIImage imageNamed:@"每月还款金额"];
            lview.titleLable.text=@"每月还款金额";
            lview.detailLable.text=@"500";

        }else if (i==3){
            lview.imgImageview.image=[UIImage imageNamed:@"未入账明细"];
            lview.titleLable.text=@"未入账明细";
            lview.detailLable.text=@"2笔";

        }else if (i==4){
            lview.imgImageview.image=[UIImage imageNamed:@"还款明细"];
            lview.titleLable.text=@"贷款明细";
            lview.detailLable.text=@"点击查看";
            //添加点击手势
            UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2-2,97)];
            imgView.backgroundColor=[UIColor clearColor];
            [lview addSubview:imgView];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
            imgView.userInteractionEnabled=YES;
            [imgView addGestureRecognizer:tap];


        }
        [uperView addSubview:lview];
       // }
        
        
        
    }
    
    UILabel *lineLable1=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-2, 0, 1, 200)];
    lineLable1.backgroundColor=[UIColor lightGrayColor];
    [uperView addSubview:lineLable1];
    UILabel *lineLable2=[[UILabel alloc]initWithFrame:CGRectMake(0, 99, kScreenWidth, 1)];
    lineLable2.backgroundColor=[UIColor lightGrayColor];
    [uperView addSubview:lineLable2];
    
    
}
-(void)tapClick{
    
       NSLog(@"66666");
    LoanDetailViewController *vc=[[LoanDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

-(void)creatCircle{
    
    
    self.percentage=0.3;
    NSInteger wigthY=0;
    if (kScreenWidth==320) {
        wigthY=94;
    }else{
        wigthY=124;
    }
    THCircularProgressView *example1 = [[THCircularProgressView alloc] initWithFrame:CGRectMake(kScreenWidth/2-100, wigthY, 200, 200)];
    
    example1.progressColor = [UIColor orangeColor];
    //example1.progressBackgroundColor = [UIColor blackColor];
    example1.percentage = self.percentage;
    example1.progressBackgroundMode = THProgressBackgroundModeCircle;
    example1.progressMode = THProgressModeDeplete;
    example1.lineWidth = 5.0f;
    example1.clockwise = NO;
    [self.view addSubview:example1];

    //中间描述
    UIView *centerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 80)];
    centerView.backgroundColor=[UIColor clearColor];
    centerView.center=CGPointMake(100, 100);
    [example1 addSubview:centerView];
    
    UILabel *lal1=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 150, 30)];
    lal1.textAlignment=NSTextAlignmentCenter;
    lal1.font=[UIFont systemFontOfSize:15];
    lal1.text=@"剩余2000元";
    //富文本
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:@"剩余2000元"];
    [str beginEditing];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(2, 4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 4)];
    lal1.attributedText=str;
    lal1.numberOfLines=0;
    [centerView addSubview:lal1];
    
    
    UILabel *lal2=[[UILabel alloc]initWithFrame:CGRectMake(0, 35, 150, 40)];
    lal2.textAlignment=NSTextAlignmentCenter;
    lal2.font=[UIFont systemFontOfSize:12];
    [lal2 setTextColor:[UIColor lightGrayColor]];
    lal2.text=@"正常还款";
    [centerView addSubview:lal2];

    
    
    
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
