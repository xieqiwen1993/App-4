//
//  FailedViewController.h
//  App
//
//  Created by Gaiminghui on 16/4/13.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FailedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *returnRootBtn;

@property (weak, nonatomic) IBOutlet UIButton *contactBtn;

@property (weak, nonatomic) IBOutlet UIButton *resubmitBtn;


- (IBAction)resubmitClick:(id)sender;

- (IBAction)contactClick:(id)sender;

- (IBAction)returnRootClick:(id)sender;

@end
