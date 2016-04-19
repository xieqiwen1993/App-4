//
//  FindPasswordViewController.h
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import "SuperclassViewController.h"

@interface FindPasswordViewController : SuperclassViewController


@property (weak, nonatomic) IBOutlet UITextField *numberText;

@property (weak, nonatomic) IBOutlet UITextField *messageText;

@property (weak, nonatomic) IBOutlet UIButton *getVerifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *imageText;

@property (weak, nonatomic) IBOutlet UIImageView *getImgImageView;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

- (IBAction)getVerifyNum:(id)sender;

- (IBAction)nextClick:(id)sender;




@end
