//
//  LandingViewController.h
//  TXSLiCai
//
//  Created by huangkai on 15/10/30.
//  Copyright © 2015年 Arvin. All rights reserved.
//
#import "SuperclassViewController.h"
#import <UIKit/UIKit.h>

@interface LandingViewController : SuperclassViewController
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UITextField *efficacyTextField;


@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *lostBtn;


- (IBAction)registClick:(id)sender;


- (IBAction)lostPasswordClick:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextClick:(UIButton *)sender;

@property(nonatomic,strong)UIView *reminderBgView;

@property(nonatomic,strong)UIView *registerBgView;

//push进来的页面 1我的（未登陆） 2修改手机号 3返回两次
@property (nonatomic,assign)NSInteger fromPage;
@end
