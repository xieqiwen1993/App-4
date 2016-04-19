//
//  RegisterViewController.m
//  TXSLiCai
//
//  Created by huangkai on 15/10/30.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import "RegisterViewController.h"
#import "TabBarViewController.h"
#import "LoginViewController.h"
////#import "SettingPasswordViewController.h"
//#import "UserRegAgreementViewController.h"
//#import "CommenWebView.h"
//#import "CLLockVC.h"
@interface RegisterViewController ()<UITextFieldDelegate>
{
    NSString *_imgVertify;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden=YES;
    //[ToolMethod settingNavbarTitle:self ForString:@"注册验证手机"];
    self.title=@"注册";
    
    [self fristCreatAllView];
    [self initAllView];
 
    _imgVertify = _strImgCode;
    
    [self settingImgCode:NO];
    
    _timeOutSecond = 60;
//    //获取验证码
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeOutMethod) userInfo:nil repeats:YES];
//    [_timer setFireDate:[NSDate distantPast]];
    
    [self reGetImageKey];
    [self.secureBtn addTarget:self action:@selector(secturetyClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)secturetyClick{
    //[ToolMethod toPICCPage:self IsHideTabbar:YES];
}

/**
 *  设置图形验证码框是否显示
 *
 *  @param isShowTextfield Yes 隐藏 NO 显示
 */
- (void)settingImgCode:(BOOL)isShowTextfield{
    
    _txtCode.hidden = isShowTextfield;
    _imgCode.hidden = isShowTextfield;
    if (isShowTextfield) {
        return;
    } else {
//        self.txtCode.frame=CGRectMake(60*kWidthRatio, 670*kHeightRatioFrame + 195*kHeightRatio, 760*kWidthRatio, 136*kHeightRatio);
//        self.txtCode.delegate = self;
//        self.imgCode.frame=CGRectMake(835*kWidthRatio, self.txtCode.frame.origin.y, 345*kWidthRatio, 136*kHeightRatio);
//        self.imgCode.backgroundColor=[UIColor redColor];
        self.imgCode.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reGetImageKey)];
        [self.imgCode addGestureRecognizer:tap];
//        self.nextBtn.frame=CGRectMake(60*kScreenWidth/1242, 865*kHeightRatioFrame + 195*kHeightRatio,  1122*kScreenWidth/1242, 141*kScreenHeight/2208);
//        self.protocolLabel.frame=CGRectMake(0, 1040*kHeightRatioFrame + 195*kHeightRatio, kScreenWidth, 55*kHeightRatio);
//        self.safeBtn.frame=CGRectMake(0, 1055*kHeightRatioFrame + 300*kHeightRatio, kScreenWidth, 50*kHeightRatio);
    }
}

-(void)initAllView{
    
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        //给电话号码打码
    //NSString *phoneNumber = [_strPhoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.inputTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.inputTextField.delegate = self;
    
    
  //  self.recommendTextField.keyboardType=UIKeyboardTypeNumberPad;

    self.numberBtn.frame=CGRectMake(824*kWidthRatio,self.inputTextField.frame.origin.y+8*kHeightRatio, 350*kWidthRatio, 120*kHeightRatio);
    self.numberBtn.layer.masksToBounds=YES;
    self.numberBtn.layer.cornerRadius=3;
    self.numberBtn.backgroundColor=[UIColor colorWithRed:1 green:0.4 blue:0.38 alpha:1];
    self.nextBtn.frame=CGRectMake(60*kScreenWidth/1242, 865*kHeightRatioFrame,  1122*kScreenWidth/1242, 141*kScreenHeight/2208);
    
    self.protocolLabel.frame=CGRectMake(0, 1040*kHeightRatioFrame, kScreenWidth, 55*kHeightRatio);
    self.protocolLabel.textColor=[UIColor colorWithRed:0.62 green:0.64 blue:0.66 alpha:1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toUserAgreementController)];
    _protocolLabel.userInteractionEnabled = YES;
    [_protocolLabel addGestureRecognizer:tap];

    self.safeBtn.frame=CGRectMake(-20*kWidthRatio, 1165*kHeightRatioFrame, kScreenWidth, 50*kHeightRatio);
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.protocolLabel.text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1 green:0.49 blue:0 alpha:1] range:NSMakeRange(11, 8)];

    self.protocolLabel.attributedText = str;
    
    self.nextBtn.layer.masksToBounds=YES;
    self.nextBtn.layer.cornerRadius=5;
    self.nextBtn.backgroundColor=[UIColor colorWithRed:0.92 green:0.28 blue:0.21 alpha:1];
}

/**
 *  注册协议
 */
- (void)toUserAgreementController{
//    UserRegAgreementViewController *userreg = [[UserRegAgreementViewController alloc]init];
//    [self.navigationController pushViewController:userreg animated:YES];
    
//    CommenWebView *webView = [[CommenWebView alloc]init];
//    webView.strUrl = kRegisterProtocol;
//    webView.strTitle = @"唐小僧理财";
//    [self.navigationController pushViewController:webView animated:YES];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.inputTextField resignFirstResponder];
    //[self.recommendTextField resignFirstResponder];
}

/**
 *  移除弹出层
 */
- (void)hidMessageView{
    [_registerBgView removeFromSuperview];
    
//    BOOL hasPwd = [CLLockVC hasPwd];
//    if(hasPwd==NO){
//    
//        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
////         [lockVC.navigationController popViewControllerAnimated:YES];
//            //去设置交易密码
//            SettingPasswordViewController *setPassword = [[SettingPasswordViewController alloc]init];
//            [self.navigationController pushViewController:setPassword animated:YES];
//            [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:kFutureDate];
//
//        } NavController:self.navigationController];
////    
//    }else{
//        //去设置交易密码
//        SettingPasswordViewController *setPassword = [[SettingPasswordViewController alloc]init];
//        [self.navigationController pushViewController:setPassword animated:YES];
//    }
//    
  
}

/**
 *  注册reGetSms
 *
 *  @param sender
 */
- (IBAction)nextClick:(UIButton *)sender;{
   
    
    [self.view endEditing:YES];
    if (![ToolMethod isMobileNumber:_numTextField.text])
    {
        [self showPropt:@"手机号码格式不正确"];
        return;
    }else if(![ToolMethod isVerificationCode:_inputTextField.text]){
        //短信验证码
        [self showPropt:@"短信验证码格式不正确"];
    } else if(_txtCode.text.length != 4){
        [self showPropt:@"验证码格式不正确"];
        return;
    }
    else {
        [self userRegister];
    }
}

- (IBAction)numberClick:(UIButton *)sender {
    
    [self reGetSms];
}

/**
 *  获取验证码倒计时
 */
- (void)timeOutMethod
{
    self.numberBtn.userInteractionEnabled = NO;
    [self.numberBtn setTitle:[NSString stringWithFormat:@"%@秒",@(_timeOutSecond)] forState:UIControlStateNormal];
    _timeOutSecond --;
    if (_timeOutSecond == -1)
    {
        [_timer invalidate];
        _timer = nil;
        [self.numberBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.numberBtn.backgroundColor=[UIColor colorWithRed:1 green:0.4 blue:0.38 alpha:1];
        _timeOutSecond = 60;
        self.numberBtn.userInteractionEnabled = YES;
        [self.numberBtn
         setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
            LoginViewController *lllogin=[[LoginViewController alloc]init];
            [self.navigationController pushViewController:lllogin animated:YES];
            

            
        } else {
            //图形验证🐴错误重新获取
//            if ([[responseObject objectForKey:@"errorcode"] isEqualToString:@"invalidparameter"]) {
//                [self reGetImageKey];
//                _txtCode.text = @"";
//                [self showPropt:@"图形验证码错误"];
//            } else {
//                [self showErrorMsgWithResponse:responseObject OtherMsg:@"获取验证码失败"];
//            }
            LoginViewController *lllogin=[[LoginViewController alloc]init];
            [self.navigationController pushViewController:lllogin animated:YES];

            
        }
        
        [self hideProgress];
        
    } failure:^(NSError *error) {
        
        [self hideProgress];
        
        NSLog(@"userRegister_error___%@",error);
    }];
}

/**
 *  重新获取验证码
 */
- (void)reGetSms{
    
    if (!_txtCode.hidden) {
        _imgVertify = _txtCode.text;
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
        
        [self hideProgress];
        
        NSLog(@"sendUserSms_error___%@",error);
    }];
}

/**
 *  图形验证码
 */
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
            _imgCode.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:stringImage options:0]];
            
        } else {
            
            //[self showErrorMsgWithResponse:responseObject OtherMsg:@""];
            
            //请求失败
            NSLog(@"getImageKey_error_----%@",[responseObject objectForKey:@"errorcode"]);
        }
        
        [self hideProgress];
        
    } failure:^(NSError *error) {
        
        [self hideProgress];
        
        NSLog(@"getImageKey_error___%@",error);
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


@end
