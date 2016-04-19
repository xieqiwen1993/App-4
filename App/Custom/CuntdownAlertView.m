//
//  CuntdownAlertView.m
//  TangXSLiCai
//
//  Created by homer on 15/9/1.
//  Copyright (c) 2015年 YXF. All rights reserved.
//

#import "CuntdownAlertView.h"

@implementation CuntdownAlertView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self showPrompt:NO];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame IsWithDraw:(BOOL)isWithDraw{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self showPrompt:isWithDraw];
    
    return self;
}

//显示倒计时层
- (void)showPrompt:(BOOL)isWithDraw{
    
    UIView *viewBg = [[UIView alloc]initWithFrame:CGRectMake(40, 150, kScreenWidth - 80, 145)];
    viewBg.layer.cornerRadius = 8;
    viewBg.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewBg];
    
    UIImageView *imgPay = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, viewBg.frame.size.width - 10, 69)];
    if (isWithDraw) {
        imgPay.image = [UIImage imageNamed:@"ProcessDeposit3.png"];
    } else {
        imgPay.image = [UIImage imageNamed:@"ProcessDeposit3.jpg"];
    }
    [viewBg addSubview:imgPay];
    
    _lblPrompt = [[UILabel alloc]initWithFrame:CGRectMake(5, 85, viewBg.frame.size.width - 10, 35)];
    _lblPrompt.textAlignment = NSTextAlignmentCenter;
    _lblPrompt.font = [UIFont systemFontOfSize:14];
    _lblPrompt.lineBreakMode = NSLineBreakByWordWrapping;
    _lblPrompt.numberOfLines = 2;
    [viewBg addSubview:_lblPrompt];
    
    _btnTime = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnTime.frame = CGRectMake(5, _lblPrompt.frame.size.height + _lblPrompt.frame.origin.y + 15, viewBg.frame.size.width - 10, 30);
    [_btnTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnTime.backgroundColor = [UIColor colorWithRed:0.9 green:0.09 blue:0.18 alpha:1];
    _btnTime.enabled = NO;
    _btnTime.layer.cornerRadius = _btnTime.frame.size.height * 0.5;
//    [viewBg addSubview:_btnTime];
}
@end
