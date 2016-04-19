//
//  MyLoanView.h
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLoanView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgImageview;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;


@property (weak, nonatomic) IBOutlet UILabel *detailLable;




+(MyLoanView *)instanceTextView;

@end
