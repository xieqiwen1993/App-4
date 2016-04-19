//
//  LoanDetailViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import "LoanDetailViewController.h"
#import "LoanDetailView.h"
#import "TimedetailLoanViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UILabel+ContentSize.h"

@interface LoanDetailViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scrolleView;

@end

@implementation LoanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"贷款明细";
    // 1.创建UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight); // frame中的size指UIScrollView的可视范围
    scrollView.backgroundColor =[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self.view addSubview:scrollView];
    
         // 2.创建UIImageView（图片）
//         UIImageView *imageView = [[UIImageView alloc] init];
//         imageView.image = [UIImage imageNamed:@"big.jpg"];
//         CGFloat imgW = imageView.image.size.width; // 图片的宽度
//         CGFloat imgH = imageView.image.size.height; // 图片的高度
//         imageView.frame = CGRectMake(0, 0, imgW, imgH);
//         [scrollView addSubview:imageView];
    NSArray *arr=@[@"商品：iPhone1",@"商品：iPhone2",@"商品：iPhone3",@"商品：iPhone4",@"商品：iPhone5",@"商品：iPhone6",@"商品：iPhone7",@"商品：iPhone8",@"商品：iPhone9  伴随着张震岳的这首老歌，仿佛我又回到了过去，回到伴随着张震岳的这首老歌，回到"];
    UILabel *testLal=[[UILabel alloc]init];
    testLal.frame=CGRectMake(12, 10, kScreenWidth-80,20);
    testLal.font=[UIFont systemFontOfSize:14];
    testLal.numberOfLines=0;
    testLal.lineBreakMode=NSLineBreakByWordWrapping;
    testLal.text=[arr objectAtIndex:8];
    NSInteger height=[testLal contentSize].height;
    height=height+26*8+80;

    for (int i=0; i<2; i++) {
        LoanDetailView *loaV=[LoanDetailView instanceTextView];
        UIView *orginV=[loaV originalvIew];
        //orginV.backgroundColor=[UIColor yellowColor];
        orginV.frame=CGRectMake(0, (height+20)*i, kScreenWidth-50, height);
        [scrollView addSubview:orginV];
        //还款明细加点击
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        loaV.tapImage.userInteractionEnabled=YES;
        [loaV.tapImage addGestureRecognizer:tap];


    }
    
         // 3.设置scrollView的属性
    
         // 设置UIScrollView的滚动范围（内容大小）
    scrollView.contentSize = CGSizeMake(kScreenWidth-50, 2000);
    
         // 隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
         // 用来记录scrollview滚动的位置
     //    scrollView.contentOffset = ;
    
         // 去掉弹簧效果
     //    scrollView.bounces = NO;
    
         // 增加额外的滚动区域（逆时针，上、左、下、右）
         // top  left  bottom  right
         scrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
         self.scrolleView = scrollView;

    // Do any additional setup after loading the view from its nib.
}
-(void)tapClick{
    NSLog(@"点击还款明细！");
    TimedetailLoanViewController *vc=[[TimedetailLoanViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
