//
//  RegisterViewController.h
//  TXSLiCai
//
//  Created by huangkai on 15/10/30.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperclassViewController.h"
@interface RegisterViewController : SuperclassViewController

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (weak, nonatomic) IBOutlet UITextField *numTextField;

@property (weak, nonatomic) IBOutlet UILabel *protocolLabel;

@property (weak, nonatomic) IBOutlet UIButton *numberBtn;

- (IBAction)numberClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextClick:(UIButton *)sender;

//定时器
@property(nonatomic,retain)NSTimer * timer;
@property(nonatomic,assign)NSInteger timeOutSecond;

@property(nonatomic,strong)UIView *reminderBgView;

@property(nonatomic,strong)UIView *registerBgView;

/**
 *  电话号码
 */
@property(nonatomic,copy)NSString *strPhoneNumber;

/**
 *  Imgkey
 */
@property(nonatomic,copy)NSString *strImgkey;

/**
 *  imgCode 图形验证码
 */
@property(nonatomic,copy)NSString *strImgCode;

/**
 *  图形验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *txtCode;

/**
 *  图形验证码
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgCode;


@end
