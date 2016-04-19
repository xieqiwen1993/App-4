//
//  SetingViewController.h
//  App
//
//  Created by Gaiminghui on 16/4/13.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *aboutBtn;
- (IBAction)aboutClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *quitBtn;

- (IBAction)quitClick:(id)sender;


@end
