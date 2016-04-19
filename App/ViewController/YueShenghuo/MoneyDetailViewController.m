//
//  MoneyDetailViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/12.
//  Copyright © 2016年 company. All rights reserved.
//

#import "MoneyDetailViewController.h"

@interface MoneyDetailViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation MoneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"商家快讯";
    
    
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(20, 84, kScreenWidth-40, kScreenHeight)];
    self.scrollView.backgroundColor=[UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(0,1000);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
   
    UILabel *lal1=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.scrollView.frame.size.width-10, 25)];
    lal1.text=@"第十期有奖名单，，，";
    lal1.textColor=[UIColor orangeColor];
    lal1.font=[UIFont systemFontOfSize:15];
    [self.scrollView addSubview:lal1];
    UILabel *lal2=[[UILabel alloc]initWithFrame:CGRectMake(10, 38, self.scrollView.frame.size.width-10, 25)];
    lal2.text=@"2015/09/25，，，";
    lal2.textColor=[UIColor lightGrayColor];
    lal2.font=[UIFont systemFontOfSize:13];
    [self.scrollView addSubview:lal2];
    
    UILabel *lal3=[[UILabel alloc]initWithFrame:CGRectMake(0, 65, self.scrollView.frame.size.width-10, 1)];
    lal3.backgroundColor=[UIColor lightGrayColor];
    [self.scrollView addSubview:lal3];
    
    UIImageView *ima=[[UIImageView alloc]initWithFrame:CGRectMake(10, 73, self.scrollView.frame.size.width-20, 150)];
    ima.image=[UIImage imageNamed:@"商家快讯"];
    [self.scrollView addSubview:ima];


    //高度不定的lable
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, ima.frame.origin.y+ima.frame.size.height+5, ima.frame.size.width, 50)];
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=[UIColor lightGrayColor];
    label.text = @"    今天下午全市多云到阴有阵雨或雷雨，今天夜里到明天阴有阵雨，雨量可达大雨。 东北风5-6级阵风7级，逐渐增强到6-7级阵风8级。 今self.backView.frame.size.width, 20车。    ";
    //清空背景颜色
    label.backgroundColor = [UIColor clearColor];
    //设置字体颜色为白色
    //label.textColor = [UIColor whiteColor];
    //设置label的背景色为黑色
    //label.backgroundColor = [UIColor blackColor];
    //文字居中显示
    label.textAlignment = NSTextAlignmentCenter;
    //自动折行设置
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    //自适应高度
    CGRect txtFrame = label.frame;
    
    label.frame = CGRectMake(10, 35, 300,
                             txtFrame.size.height =[label.text boundingRectWithSize:CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
                                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:nil].size.height);
    label.frame = CGRectMake(10, ima.frame.origin.y+ima.frame.size.height+5, ima.frame.size.width, txtFrame.size.height);

    [self.scrollView addSubview:label];
    
    

    

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

@end
