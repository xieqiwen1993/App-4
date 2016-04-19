//
//  DetailViewMessViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import "DetailViewMessViewController.h"

@interface DetailViewMessViewController ()
@property(nonatomic, strong)UIView *backGrounView;
@property(nonatomic,strong)UILabel *lable1;

@end

@implementation DetailViewMessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"系统消息";
    
    
    self.backGrounView=[[UIView alloc]initWithFrame:CGRectMake(20, 74, kScreenWidth-40, 300)];
    self.backGrounView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.backGrounView];
    
    self.lable1=[[UILabel alloc]initWithFrame:CGRectMake(5, 3,self.backGrounView.frame.size.width, 20)];
    self.lable1.text=@"恭喜您注册成功！";
    [self.backGrounView addSubview:self.lable1];
    
    UILabel *lableLine=[[UILabel alloc]initWithFrame:CGRectMake(0, 26, self.backGrounView.frame.size.width, 1)];
    lableLine.backgroundColor=[UIColor lightGrayColor];
    [self.backGrounView addSubview:lableLine];
    
    
    
//    self.backView.frame=CGRectMake(20, 74, kScreenWidth-40, 300);
//    self.titleView.frame=CGRectMake(5, 3, self.backView.frame.size.width, 20);
    

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, self.backGrounView.frame.size.width-10, 50)];
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
    label.frame = CGRectMake(10, 35, self.backGrounView.frame.size.width-15, txtFrame.size.height);
    
    [self.backGrounView addSubview:label];
    
    self.backGrounView.frame=CGRectMake(20, 74, kScreenWidth-40, txtFrame.size.height+40);

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
