//
//  LoanDetailView.h
//  App
//
//  Created by Gaiminghui on 16/4/11.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LoanDetailView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *backImageview;
@property(nonatomic,strong)UIImageView *tapImage;

+(LoanDetailView *)instanceTextView;
-(UIView *)originalvIew;
@end
