//
//  CuntdownAlertView.h
//  TangXSLiCai
//
//  Created by homer on 15/9/1.
//  Copyright (c) 2015年 YXF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CuntdownAlertView : UIView

/**
 *  交易成功的提示语
 */
@property(nonatomic,retain)UILabel *lblPrompt;

/**
 *  显示倒计时的button
 */
@property (nonatomic,retain)UIButton *btnTime;

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame IsWithDraw:(BOOL)isWithDraw;

@end
