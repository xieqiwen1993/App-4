//
//  LoginViewController.m
//  TXSLiCai
//
//  Created by huangkai on 15/10/16.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LandingViewController.h"
#import "RegistOkViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];

    //[self initAllView];
    // Do any additional setup after loading the view from its nib.
}

-(void)initAllView{
    self.iconImageView.frame=CGRectMake(336*kScreenWidth/1242, 75*kScreenHeight/2208+264, 569*kScreenWidth/1242,223*kScreenHeight/2208);
    self.titleLabel.frame=CGRectMake(0, self.iconImageView.frame.origin.y+self.iconImageView.frame.size.height+90*kScreenHeight/2208, kScreenWidth, 50*kScreenHeight/2208);
    self.titleLabel.text=@"完成注册";
    self.inputTextField.frame=CGRectMake(60*kScreenWidth/1242,self.titleLabel.frame.size.height+self.titleLabel.frame.origin.y+45*kScreenHeight/2208 , 1122*kScreenWidth/1242, 136*kScreenHeight/2208);
    self.inputTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.nextBtn.frame=CGRectMake(60*kScreenWidth/1242, self.inputTextField.frame.origin.y+self.inputTextField.frame.size.height+55*kScreenHeight/2208,  1122*kScreenWidth/1242, 141*kScreenHeight/2208);
    self.nextBtn.layer.masksToBounds=YES;
    self.nextBtn.layer.cornerRadius=15.0;

    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.inputTextField resignFirstResponder];

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

- (IBAction)nextClick:(UIButton *)sender {
    //[self showProgress];
    
    if([_inputTextField.text isEqualToString:@""]){
        [self showPropt:@"请输入姓名"];
    } else if(![ToolMethod isidCardNumber:_cardNumTextFiled.text]){
        [self showPropt:@"身份证号格式不正确"];
    } else {
        
        
        [self requestRegister];
        
        
    }

    
    
  
    
    
    
    
}
-(void)requestRegister{
    
    
    NSString *serviceAdress = [NSString stringWithFormat:kServerUrl,@"Anonymous/user/register"];
    NSDictionary *parameterDic = @{@"accesstoken":@"",
                                   };
    [[RequestNetwork manager]postSeverAddress:serviceAdress parameters:parameterDic success:^(id responseObject) {
        
        NSLog(@"userRegister--%@",responseObject);
        NSString *requestResult = [[responseObject objectForKey:@"result"] stringValue];
        if ([requestResult isEqualToString:@"1"]) {
            NSLog(@"注册成功");
            
            [TangXSSingleton sharedInstance].userAccessToken = [NSString stringWithFormat:@"%@",responseObject[@"accesstoken"]];
            //取到accesstoken保存起来,在需要的地方使用
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[TangXSSingleton sharedInstance].userAccessToken forKey:kAccessToken];
            [userDefaults synchronize];
            //注册成功
            RegistOkViewController * regiVc=[[RegistOkViewController alloc]init];
            regiVc.isSuccess=YES;
            [self.navigationController pushViewController:regiVc animated:YES];
            
            
        } else {
            
            //[self showErrorMsgWithResponse:responseObject OtherMsg:@"注册失败"];
            
            //请求失败
            //NSLog(@"userRegister_error_----%@",[responseObject objectForKey:@"errorcode"])
            RegistOkViewController * regiVc=[[RegistOkViewController alloc]init];
            regiVc.isSuccess=NO;
            [self.navigationController pushViewController:regiVc animated:YES];
            
        }
        
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"userRegister_error___%@",error);
    }];
    
    
    
    
}
//显示消息
- (void)showPropt:(NSString *)message {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
        
}
 

@end
