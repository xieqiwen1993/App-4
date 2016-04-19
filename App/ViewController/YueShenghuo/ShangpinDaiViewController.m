//
//  ShangpinDaiViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/19.
//  Copyright © 2016年 company. All rights reserved.
//

#import "ShangpinDaiViewController.h"
#import "LDSlider.h"
#import "ApplicationViewController.h"

@interface ShangpinDaiViewController (){
    NSArray *_arr;
    NSArray *_arr1;
}
@property(nonatomic,strong)UIView * toastView;

@end

@implementation ShangpinDaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arr=[[NSArray alloc]init];
    _arr1=[[NSArray alloc]init];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"商品贷";

    
    LDSlider *slider=[[LDSlider alloc] initWithFrame:CGRectMake((kScreenWidth-300)/2, 420, 300, 50) titles:@[@"0",@"1000",@"3000",@"5000",@"7000",@"9000"] firstAndLastTitles:@[@""] defaultIndex:1 sliderImage:[UIImage imageNamed:@"按钮@2x"]];
    [self.view addSubview:slider];
    slider.block=^(int index){
        NSLog(@"当前index等于%d",index);
    };
    
    
    
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
        if ([str isEqualToString:@"分期期限"]) {
            btn.tag=500+i;
        }else{
            btn.tag=600+i;
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:btn];
        
        UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(20, btn.frame.origin.y+btn.frame.size.height+3, btn.frame.size.width-40, 1)];
        line.backgroundColor=[UIColor lightGrayColor];
        [view1 addSubview:line];
    }
    
    
}
//点击选择
-(void)btnClick:(UIButton*)btn{
    //[btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
   // 500 501 502
    if (btn.tag<599) {
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
 
    }else{
        for (int i=600; i<603; i++) {
            //首付类型
            if (btn.tag==i) {
                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                self.downpayBtn.titleLabel.text=[_arr1 objectAtIndex:i-600] ;
                
            }else{
                
                UIButton *btn=(UIButton *)[self.view viewWithTag:i];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }

    }
    
    self.toastView.hidden=YES;
    
    
}
- (IBAction)monthClick:(id)sender {
    //月份选择
    _arr=@[@"0个月",@"6个月",@"12个月"];
    [self makeToastWithArr:_arr andStr:@"分期期限"];
   
}

- (IBAction)downPayClick:(id)sender {
    //首付选择
    _arr1=@[@"0首付",@"1首付",@"12首付"];
    [self makeToastWithArr:_arr1 andStr:@"首付类型"];
   
}

- (IBAction)beginClick:(id)sender {
    //开始试算
        ApplicationViewController *vc=[[ApplicationViewController alloc]init];
    
    vc.isfromVc=0;
        [self.navigationController pushViewController:vc animated:YES];
    
    
}
@end
