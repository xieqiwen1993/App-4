//
//  NeccesaryViewController.h
//  App
//
//  Created by Gaiminghui on 16/4/12.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NeccesaryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextFiedl;
@property (weak, nonatomic) IBOutlet UITextField *messaCodeTextF;

@property (weak, nonatomic) IBOutlet UITextField *imgCodeTextF;

@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imgVerifyImgView;

//定时器
@property(nonatomic,retain)NSTimer * timer;
@property(nonatomic,assign)NSInteger timeOutSecond;

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


- (IBAction)getCodeClick:(id)sender;

- (IBAction)nextClick:(id)sender;


@end
