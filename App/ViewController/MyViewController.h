//
//  MyViewController.h
//  App
//
//  Created by Gaiminghui on 16/4/7.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *userImagView;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UIImageView *bacgourImgView;

- (IBAction)registerClick:(id)sender;



@end
