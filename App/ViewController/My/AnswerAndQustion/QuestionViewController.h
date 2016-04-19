//
//  QuestionViewController.h
//  App
//
//  Created by Gaiminghui on 16/4/13.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnOne;

@property (weak, nonatomic) IBOutlet UIButton *btnTwo;

@property (weak, nonatomic) IBOutlet UIButton *btnThree;

@property (weak, nonatomic) IBOutlet UIButton *btnFour;


- (IBAction)firstClick:(id)sender;

- (IBAction)secondClick:(id)sender;
- (IBAction)thirdClick:(id)sender;


- (IBAction)forthClick:(id)sender;


@end
