//
//  LandingViewController.m
//  TXSLiCai
//
//  Created by huangkai on 15/10/30.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import "LandingViewController.h"
//#import "VerifyPhoneViewController.h"
#import "RegisterViewController.h"
#import "TabBarViewController.h"
#import "TangXSSingleton.h"
#import "RegisterViewController.h"
#import "FindPasswordViewController.h"


@interface LandingViewController ()<UITextFieldDelegate>
{
    //图形验证码的key
    NSString *imgKey;
    //是否是商户
    BOOL _isStore;
}
@end

@implementation LandingViewController


-(void)viewWillAppear:(BOOL)animated{
    //即将出现时隐藏tabbar
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    delegate.myTabar.hidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
    
    [self.lostBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
//    if (_fromPage == 1 || _fromPage == 2) {
//        //返回首页－－－ 来自1我的（未登陆）
//        //返回首页－－－ 来自2修改手机号
//        [ToolMethod settingNavbarTitle:self ForString:@"登录" IsCanBack:NO];
//        [self addBackButton:self];
//
//    } else if(_fromPage == 3){
//        [ToolMethod settingNavbarTitle:self ForString:@"登录" IsCanBack:NO];
//        [self hideBackButton];
//    } else {
//        [ToolMethod settingNavbarTitle:self ForString:@"登录"];
//    }
    
    [self initAllView];
    
    [self fristCreatAllView];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    
    [self.secureBtn addTarget:self action:@selector(secturetyClick) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  添加返回按钮
 */
- (void)addBackButton:(UIViewController *)viewController{
    
    UIButton *btnBack = [[UIButton alloc]init];
    btnBack.backgroundColor = [UIColor clearColor];
    if (_fromPage == 3) {
        [btnBack addTarget:self action:@selector(backToProviousPage) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [btnBack addTarget:self action:@selector(backToMainPage) forControlEvents:UIControlEventTouchUpInside];
    }
    [btnBack setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    btnBack.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    viewController.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, buttonItem];
}

/**
 *  添加返回按钮
 */
- (void)hideBackButton{
    
    UIButton *btnBack = [[UIButton alloc]init];
    btnBack.backgroundColor = [UIColor clearColor];
    btnBack.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = leftItem;
}

/**
 *  来自趋紧总动员
 */
- (void)backToProviousPage{
    [[TangXSSingleton sharedInstance].arrTempViewController removeLastObject];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  返回上一页
 */
- (void)backToMainPage{
    
    //[ToolMethod pushNewView:self pushIndex:0];
}

- (void)secturetyClick{
    //[ToolMethod toPICCPage:self IsHideTabbar:YES];
}

- (void)createNavigationLeftBarButtonItemWithCustomView:(UIButton *)button
{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, buttonItem];
    }else{
        self.navigationItem.leftBarButtonItem = buttonItem;
    }
}

/**
 *  给图片验证码添加手势 点击切换
 */

-(void)initAllView{
    self.iconImageView.frame=CGRectMake(336*kScreenWidth/1242, 75*kScreenHeight/2208+64, 569*kScreenWidth/1242,223*kScreenHeight/2208);
    self.titleLabel.frame=CGRectMake(0, self.iconImageView.frame.origin.y+self.iconImageView.frame.size.height+90*kScreenHeight/2208, kScreenWidth, 50*kScreenHeight/2208);
    self.titleLabel.text=@"请输入手机号进行登录";
    self.inputTextField.frame=CGRectMake(60*kScreenWidth/1242,self.titleLabel.frame.size.height+self.titleLabel.frame.origin.y+45*kScreenHeight/2208 , 1122*kScreenWidth/1242, 136*kScreenHeight/2208);
    self.inputTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.inputTextField.delegate = self;
    
    self.efficacyTextField.frame=CGRectMake(60*kWidthRatio, 670*kHeightRatioFrame, 786*kWidthRatio, 136*kHeightRatio);
    
    self.nextBtn.frame=CGRectMake(60*kScreenWidth/1242, 865*kHeightRatioFrame,  1122*kScreenWidth/1242, 141*kScreenHeight/2208);
    
    
    self.registBtn.frame=CGRectMake(kScreenWidth/2-78, kScreenHeight-120, 58,30);
    self.lostBtn.frame=CGRectMake(kScreenWidth/2+(kScreenWidth/2-(kScreenWidth/2-78)-58), kScreenHeight-120, 58, 30) ;

}

//创建继续注册唐小僧会员页面
-(void)creatReminderView{

    _reminderBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _reminderBgView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(161*kWidthRatio, 455*kHeightRatioFrame, 920*kWidthRatio, 584*kHeightRatio)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.masksToBounds=YES;
    bgView.layer.cornerRadius=5;
    UIImageView *iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(385*kWidthRatio, 55*kHeightRatio, 150*kWidthRatio, 150*kHeightRatio)];
    NSArray *nameArr=@[@"此手机号码未注册",@"继续注册成为唐小僧会员"];
    NSArray *buttonArr=@[@"取消",@"确定"];
    iconImageView.image=[UIImage imageNamed:@"提示"];
    for (NSInteger i=0; i<2; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 240*kHeightRatio+i*65*kHeightRatio, 920*kWidthRatio, 55*kHeightRatio)];
        label.font=[UIFont systemFontOfSize:14];
        label.text=nameArr[i];
        label.textAlignment=1;
        [bgView addSubview:label];
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake(80*kWidthRatio+i*401*kWidthRatio, 405*kHeightRatio, 359*kWidthRatio, 120*kHeightRatio);
        [button setTitle:buttonArr[i] forState:UIControlStateNormal];
        
        button.backgroundColor=[UIColor colorWithRed:0.92 green:0.28 blue:0.21 alpha:1];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.masksToBounds=YES;
        button.layer.cornerRadius=4;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=kTagW2+i;
        [bgView addSubview:button];
    }
    [bgView addSubview:iconImageView];
    [_reminderBgView addSubview:bgView];
    [self.view addSubview:_reminderBgView];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.inputTextField resignFirstResponder];
    [self.efficacyTextField resignFirstResponder];
}
- (BOOL)judgeIsStore{
    
    //接口判断是否登录
    NSString *accessToken = [[NSUserDefaults standardUserDefaults]objectForKey:kAccessToken];
    if (accessToken == nil || [accessToken isEqualToString:@""]) {
        self.tabBarController.tabBar.hidden = YES;
        [ToolMethod toLoginPage:self FromPage:1];
        _isStore = NO;
        return _isStore;
    } else {
        
        
        return _isStore;
    }
}

//登录
- (IBAction)nextClick:(UIButton *)sender{
    
    
    if (![ToolMethod isMobileNumber:_inputTextField.text])
    {
        [self showPropt:@"手机号码格式不正确"];
        return;
    } else {
        
        //接口判断是否登录
        NSString *accessToken = [[NSUserDefaults standardUserDefaults]objectForKey:kAccessToken];
        if (accessToken == nil || [accessToken isEqualToString:@""]) {
            //未注册，先去注册
            [BVTToastView show:@"您还没有注册，请先注册！"];
            
            
        }else{
            //已注册，去登录
            
        }
        
    }

   
    //[self.view endEditing:YES];
    
    }

-(void)btnClick:(UIButton *)btn{

    switch (btn.tag) {
        case kTagW2:
        {
            NSLog(@"取消");
            //隐藏弹出层
            [_reminderBgView removeFromSuperview];
        }
            break;
        case kTagW2+1:
        {
            NSLog(@"确定");
            //隐藏弹出层
            [_reminderBgView removeFromSuperview];
            
            [self sendUserSms:YES];
            
            RegisterViewController *registerPage=[[RegisterViewController alloc]init];
            registerPage.strPhoneNumber = _inputTextField.text;
            registerPage.strImgkey = imgKey;
            registerPage.strImgCode = _efficacyTextField.text;
            [self.navigationController pushViewController:registerPage animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - TextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (textField == _inputTextField) {
        //手机号码
        if ([toBeString length] > 11)
        {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    } else {
        //验证码
        if ([toBeString length] > 4)
        {
            textField.text = [toBeString substringToIndex:4];
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - 网络请求
/**
 *  图形验证码
 */
- (void)getImageKey{
    
    //[self showProgress];
    
    NSString *serviceAdress = [NSString stringWithFormat:kServerUrl,@"Anonymous/user/getimgcode"];
    NSDictionary *parameterDic = @{@"accesstoken":@"",
                                   @"imgkey":@""
                                   };
//    [[RequestNetwork manager]postSeverAddress:serviceAdress parameters:parameterDic success:^(id responseObject) {
//        
//        NSLog(@"getImageKey--%@",responseObject);
//        NSString *requestResult = [[responseObject objectForKey:@"result"] stringValue];
//        if ([requestResult isEqualToString:@"1"]) {
//            
//            //记录key
//            imgKey = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"imgkey"]];
//            //显示图片
//            NSString *stringImage = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"imgcode"]];
//            _efficacyImageView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:stringImage options:0]];
//            
//        } else {
//            
//            [self showErrorMsgWithResponse:responseObject OtherMsg:@""];
//            
//            //请求失败
//            NSLog(@"getImageKey_error_----%@",[responseObject objectForKey:@"errorcode"])
//        }
//        
//        [self hideProgress];
//        
//    } failure:^(NSError *error) {
//        
//        [self hideProgress];
//        
//        NSLog(@"getImageKey_error___%@",error);
//    }];
}

/**
 *  下一步获取验证码
 */
- (void)sendUserSms:(BOOL)isreg{
    
    //[self showProgress];
    
    NSString *serviceAdress = [NSString stringWithFormat:kServerUrl,@"Anonymous/user/sendusersms"];
    NSDictionary *parameterDic = @{@"accesstoken":@"",
                                   @"imgkey":imgKey,
                                   @"imgcode":_efficacyTextField.text,
                                   @"mobile":_inputTextField.text,
                                   @"isreg":[NSString stringWithFormat:@"%hhd",isreg]
                                   };
//    [[RequestNetwork manager]postSeverAddress:serviceAdress parameters:parameterDic success:^(id responseObject) {
//        
//        NSLog(@"sendUserSms--%@",responseObject);
//        NSString *requestResult = [[responseObject objectForKey:@"result"] stringValue];
//        if ([requestResult isEqualToString:@"1"]) {
//            
//            NSString *isExists = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"isexists"] ];
//            if ([isExists isEqualToString:@"1"]) {
//                //已注册
//                VerifyPhoneViewController *verifyVc=[[VerifyPhoneViewController alloc]init];
//                verifyVc.strPhoneNumber = _inputTextField.text;
//                verifyVc.strImgkey = imgKey;
//                verifyVc.strImgCode = _efficacyTextField.text;
//                [self.navigationController pushViewController:verifyVc animated:YES];
//            } else {
//                
//                //未注册 弹出层
//                isreg ? nil : [self creatReminderView];
//                
//            }
//        } else {
//            
//            if ([[responseObject objectForKey:@"errorcode"] isEqualToString:@"invalidparameter"]) {
//                [self getImageKey];
//                _efficacyTextField.text = @"";
//                [self showPropt:@"图形验证码错误"];
//            } else {
//                [self showErrorMsgWithResponse:responseObject OtherMsg:@"获取验证码失败"];
//            }
//            
//            //请求失败
//            NSLog(@"sendUserSms_error_----%@",[responseObject objectForKey:@"errorcode"])
//        }
//        
//        [self hideProgress];
//        
//    } failure:^(NSError *error) {
//        
//        [self hideProgress];
//        
//        NSLog(@"sendUserSms_error___%@",error);
//    }];
}

//注册
- (IBAction)registClick:(id)sender {
    RegisterViewController *reVc=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:reVc animated:YES];
    

}
//忘记密码
- (IBAction)lostPasswordClick:(id)sender {
    
    FindPasswordViewController * find=[[FindPasswordViewController alloc]init];
    [self.navigationController pushViewController:find animated:YES];
    
}
-(void)click{
    FindPasswordViewController * find=[[FindPasswordViewController alloc]init];
    [self.navigationController pushViewController:find animated:YES];

    
}
@end
