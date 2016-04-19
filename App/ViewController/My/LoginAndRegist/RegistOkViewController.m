//
//  RegistOkViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/8.
//  Copyright © 2016年 company. All rights reserved.
//

#import "RegistOkViewController.h"

@interface RegistOkViewController ()
//定时器
@property(nonatomic,retain)NSTimer * timer;
@property(nonatomic,assign)NSInteger timeOutSecond;

@end

@implementation RegistOkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int a=0;
    if (self.isSuccess==YES) {
        a=1;
        self.title=@"注册成功";

    }else{
        a=0;
        self.title=@"注册失败";

    }
    switch (a) {
        case 0:
        {
          //注册失败
            self.imageV.image=[UIImage imageNamed:@"叉"];
            self.lable1.text=@"真遗憾注册失败！";
            self.lable2.text=@"系统将在5秒后为您自动跳转~";
        }
            break;
        case 1:
        {
          //注册成功
            self.imageV.image=[UIImage imageNamed:@"勾"];
            self.lable1.text=@"恭喜您注册成功！";
            self.lable2.text=@"系统将在5秒后为您自动跳转~";

            
            
        }
            break;
        default:
            break;
    }
    _timeOutSecond = 5;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeOutMethod) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantPast]];

    // Do any additional setup after loading the view from its nib.
}
- (void)timeOutMethod
{
    

    self.lable2.text=[NSString stringWithFormat:@"系统将在%@秒后自动跳转！",@(_timeOutSecond)];
    _timeOutSecond --;
    if (_timeOutSecond == -1)
    {
        [_timer invalidate];
        _timer = nil;
        [self.navigationController popToRootViewControllerAnimated:YES];
//        [self.numberBtn setTitle:@"重新获取" forState:UIControlStateNormal];
//        self.numberBtn.backgroundColor=[UIColor colorWithRed:1 green:0.4 blue:0.38 alpha:1];
//        _timeOutSecond = 60;
//        self.numberBtn.userInteractionEnabled = YES;
//        [self.numberBtn
//         setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }


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
