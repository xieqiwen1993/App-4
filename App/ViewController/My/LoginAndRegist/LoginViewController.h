//
//  LoginViewController.h
//  TXSLiCai
//
//  Created by huangkai on 15/10/16.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UITextField *cardNumTextFiled;


@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;

@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordText;




- (IBAction)nextClick:(UIButton *)sender;

@end
