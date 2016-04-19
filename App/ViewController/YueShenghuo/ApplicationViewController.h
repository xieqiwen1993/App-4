//
//  ApplicationViewController.h
//  App
//
//  Created by Gaiminghui on 16/4/12.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property(nonatomic,assign) NSInteger isfromVc;
// 0 是商品贷 1是现金贷
- (IBAction)nextClick:(id)sender;

@end
