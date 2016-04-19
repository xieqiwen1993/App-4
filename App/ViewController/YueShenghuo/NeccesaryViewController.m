//
//  NeccesaryViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/12.
//  Copyright © 2016年 company. All rights reserved.
//

#import "NeccesaryViewController.h"
#import "MapViewController.h"
@interface NeccesaryViewController ()<UITextFieldDelegate>
{
    NSString *_imgVertify;
}


@end

@implementation NeccesaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"申请单";
    
    
    self.getCodeBtn.layer.masksToBounds=YES;
    self.getCodeBtn.layer.cornerRadius=3;
    //self.numberBtn.backgroundColor=[UIColor colorWithRed:1 green:0.4 blue:0.38 alpha:1];
    
    _timeOutSecond = 60;
    _imgVertify = _strImgCode;
    
    [self settingImgCode:NO];

    [self reGetImageKey];

    // Do any additional setup after loading the view from its nib.
}
- (void)settingImgCode:(BOOL)isShowTextfield{
    
    _imgCodeTextF.hidden = isShowTextfield;
    _imgVerifyImgView.hidden = isShowTextfield;
    if (isShowTextfield) {
        return;
    } else {
        //        self.txtCode.frame=CGRectMake(60*kWidthRatio, 670*kHeightRatioFrame + 195*kHeightRatio, 760*kWidthRatio, 136*kHeightRatio);
        //        self.txtCode.delegate = self;
        //        self.imgCode.frame=CGRectMake(835*kWidthRatio, self.txtCode.frame.origin.y, 345*kWidthRatio, 136*kHeightRatio);
        //        self.imgCode.backgroundColor=[UIColor redColor];
        self.imgVerifyImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reGetImageKey)];
        [self.imgVerifyImgView addGestureRecognizer:tap];
        //        self.nextBtn.frame=CGRectMake(60*kScreenWidth/1242, 865*kHeightRatioFrame + 195*kHeightRatio,  1122*kScreenWidth/1242, 141*kScreenHeight/2208);
        //        self.protocolLabel.frame=CGRectMake(0, 1040*kHeightRatioFrame + 195*kHeightRatio, kScreenWidth, 55*kHeightRatio);
        //        self.safeBtn.frame=CGRectMake(0, 1055*kHeightRatioFrame + 300*kHeightRatio, kScreenWidth, 50*kHeightRatio);
    }
}
- (void)reGetImageKey{
    
    //[self showProgress];
    
    NSString *serviceAdress = [NSString stringWithFormat:kServerUrl,@"Anonymous/user/getimgcode"];
    NSDictionary *parameterDic = @{@"accesstoken":@"",
                                   @"imgkey":@""
                                   };
    [[RequestNetwork manager]postSeverAddress:serviceAdress parameters:parameterDic success:^(id responseObject) {
        
        NSLog(@"getImageKey--%@",responseObject);
        NSString *requestResult = [[responseObject objectForKey:@"result"] stringValue];
        if ([requestResult isEqualToString:@"1"]) {
            
            //显示验证码框
            [self settingImgCode:NO];
            
            //记录key
            _strImgkey = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"imgkey"]];
            //显示图片
            NSString *stringImage = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"imgcode"]];
            _imgVerifyImgView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:stringImage options:0]];
            
        } else {
            
            //[self showErrorMsgWithResponse:responseObject OtherMsg:@""];
            
            //请求失败
            NSLog(@"getImageKey_error_----%@",[responseObject objectForKey:@"errorcode"]);
        }
        
        //[self hideProgress];
        
    } failure:^(NSError *error) {
        
        //[self hideProgress];
        
        NSLog(@"getImageKey_error___%@",error);
    }];
}
/**
 *  重新获取验证码
 */
- (void)reGetSms{
    
    if (!_imgCodeTextF.hidden) {
        _imgVertify = _imgCodeTextF.text;
    }
    
    //[self showProgress];
    
    NSString *serviceAdress = [NSString stringWithFormat:kServerUrl,@"Anonymous/user/sendusersms"];
    NSDictionary *parameterDic = @{@"accesstoken":@"",
                                   @"imgkey":@"",
                                   @"imgcode":@"",
                                   @"mobile":@""
                                   };
    [[RequestNetwork manager]postSeverAddress:serviceAdress parameters:parameterDic success:^(id responseObject) {
        
        NSLog(@"sendUserSms--%@",responseObject);
        NSString *requestResult = [[responseObject objectForKey:@"result"] stringValue];
        requestResult=@"1";
        if ([requestResult isEqualToString:@"1"]) {
            
            //获取验证码
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeOutMethod) userInfo:nil repeats:YES];
            [_timer setFireDate:[NSDate distantPast]];
            
        } else {
            
            //[self showPropt:@"请输入验证码后重新获取"];
            
            //请求失败
            NSLog(@"sendUserSms_error_----%@",[responseObject objectForKey:@"errorcode"]);
        }
        
        //[self hideProgress];
        
    } failure:^(NSError *error) {
        
        //[self hideProgress];
        
        NSLog(@"sendUserSms_error___%@",error);
    }];
}

#pragma mark UITextfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    //手机验证码
    if ([toBeString length] > 6)
    {
        textField.text = [toBeString substringToIndex:6];
        return NO;
    }
    return YES;
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

- (IBAction)getCodeClick:(id)sender {
    //获取验证码
    [self reGetSms];
}

- (IBAction)nextClick:(id)sender {
    
    
    [self.view endEditing:YES];
    if (_nameTextField.text.length<=0) {
        [self showPropt:@"请输入您的姓名"];
    }else if (![ToolMethod isMobileNumber:_phoneNumTextFiedl.text])
    {
        [self showPropt:@"手机号码格式不正确"];
        return;
    }else if(![ToolMethod isVerificationCode:_messaCodeTextF.text]){
        //短信验证码
        [self showPropt:@"短信验证码格式不正确"];
    } else if(_imgCodeTextF.text.length != 4){
        [self showPropt:@"验证码格式不正确"];
        return;
    }
    else {
        [self userRegister];
    }

    
}
/**
 *  用户注册
 */
- (void)userRegister{
    
    
    
    
    NSString *serviceAdress = [NSString stringWithFormat:kServerUrl,@"Anonymous/user/register"];
    NSDictionary *parameterDic = @{@"accesstoken":@"",
                                   @"imgkey":@"",
                                   @"smscode":@"",
                                   @"mobile":@""
                                   };
    [[RequestNetwork manager]postSeverAddress:serviceAdress parameters:parameterDic success:^(id responseObject) {
        
        NSLog(@"userRegister--%@",responseObject);
        NSString *requestResult = [[responseObject objectForKey:@"result"] stringValue];
        if ([requestResult isEqualToString:@"1"]) {
            NSLog(@"注册成功");
            MapViewController *vc=[[MapViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

            
            
            
        } else {
            //图形验证🐴错误重新获取
            //            if ([[responseObject objectForKey:@"errorcode"] isEqualToString:@"invalidparameter"]) {
            //                [self reGetImageKey];
            //                _txtCode.text = @"";
            //                [self showPropt:@"图形验证码错误"];
            //            } else {
            //                [self showErrorMsgWithResponse:responseObject OtherMsg:@"获取验证码失败"];
            //            }
            MapViewController *vc=[[MapViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

            
        }
        
        //[self hideProgress];
        
    } failure:^(NSError *error) {
        
        //[self hideProgress];
        
        NSLog(@"userRegister_error___%@",error);
    }];
}

/**
 *  获取验证码倒计时
 */
- (void)timeOutMethod
{
    self.getCodeBtn.userInteractionEnabled = NO;
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%@秒",@(_timeOutSecond)] forState:UIControlStateNormal];
    _timeOutSecond --;
    if (_timeOutSecond == -1)
    {
        [_timer invalidate];
        _timer = nil;
        [self.getCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.getCodeBtn.backgroundColor=[UIColor colorWithRed:1 green:0.4 blue:0.38 alpha:1];
        _timeOutSecond = 60;
        self.getCodeBtn.userInteractionEnabled = YES;
        [self.getCodeBtn
         setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
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
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameTextField resignFirstResponder];
    [self.phoneNumTextFiedl resignFirstResponder];
    [self.messaCodeTextF resignFirstResponder];
    [self.imgCodeTextF resignFirstResponder];
    
}


@end
