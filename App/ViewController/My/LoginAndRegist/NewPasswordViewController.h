//
//  NewPasswordViewController.h
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import "SuperclassViewController.h"

@interface NewPasswordViewController : SuperclassViewController

@property (weak, nonatomic) IBOutlet UITextField *PwdText;

@property (weak, nonatomic) IBOutlet UITextField *verifyPwdText;

@property (weak, nonatomic) IBOutlet UIButton *pwdOkBtn;

- (IBAction)pwdOkClick:(id)sender;


@end
