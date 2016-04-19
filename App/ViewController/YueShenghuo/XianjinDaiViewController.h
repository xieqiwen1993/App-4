//
//  XianjinDaiViewController.h
//  App
//
//  Created by Gaiminghui on 16/4/19.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XianjinDaiViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *monthBtn;

@property (weak, nonatomic) IBOutlet UIButton *loanBtn;
@property (weak, nonatomic) IBOutlet UIButton *beginBtn;

- (IBAction)monthClick:(id)sender;

- (IBAction)loanClick:(id)sender;

- (IBAction)beginClick:(id)sender;

@end
