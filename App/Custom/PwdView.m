//
//  PwdView.m
//  TangXSLiCai
//
//  Created by homer on 15/8/13.
//  Copyright (c) 2015年 YXF. All rights reserved.
//

#import "PwdView.h"

@interface PwdView ()
{
    //数字键盘的背景view
    UIView *keyboardBg;
    //固定基础tag值
    int staticTag;
    //label的tag
    int lblTag;
    //最后的密码
//    NSMutableString *_password;
}
@end

@implementation PwdView

-(id)initWithFrame:(CGRect)frame Type:(BOOL)viewType{

    self=[super initWithFrame:frame];
    if (self) {
        _password = [[NSMutableString alloc]init];
        lblTag = 1;
        staticTag = 1500;
        [self createKeyboard:viewType];
    }
    
    return self;
}

- (void)backToPrevious{
    
    if (self.popMyBlock) {
        self.popMyBlock(self.password);
    }
    
}

-(void)showWithPush:(pushBlock)block{

    self.pushMyBlock=block;
}

-(void)showWithPop:(popBlock)block{

    self.popMyBlock =block;
}

- (void)createKeyboard :(BOOL)viewType{
    
    //灰色背景view
    if (viewType) {
        keyboardBg = [[UIView alloc]initWithFrame:CGRectMake(0, BOUND_W(self) - (227 + 205*kHeightRatio + 64), kScreenWidth, 227)];
    } else {
        keyboardBg = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - (227 + 304*kHeightRatio + 84 + 15), kScreenWidth, 227)];
    }
    keyboardBg.backgroundColor = RGBA(222, 227, 233, 1.0);
    [self addSubview:keyboardBg];
    
    //label的创建
    for (int i = 0; i < 6; i ++) {
        
        UILabel *lblPwd;
        if (viewType) {
            lblPwd = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 291)* 0.5 + i * 49, 0, 46, 46)];
        } else {
            lblPwd = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 291)* 0.5 + i * 49, 0, 46, 46)];
        }
        lblPwd.font = [UIFont boldSystemFontOfSize:20];
        lblPwd.tag = staticTag + 101 + i;
        lblPwd.textAlignment = NSTextAlignmentCenter;
//        lblPwd.layer.borderWidth = 1.5;
//        lblPwd.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1].CGColor;
        lblPwd.backgroundColor=[UIColor whiteColor];
        [self  addSubview:lblPwd];
    }
    
    //button创建
    CGFloat buttonWidth = kScreenWidth / 3;
    for (int i = 0; i < 4; i ++) {
        for (int j = 0; j < 3; j ++) {
            UIButton *btnNumber = [[UIButton alloc]initWithFrame:CGRectMake(j * buttonWidth + j + 1, i + 1 + i * 56, buttonWidth, 56)];
            btnNumber.tag = staticTag + i*3+j+1;
            btnNumber.titleLabel.font = [UIFont systemFontOfSize:25];
            if (i == 3 && j == 0) {
                btnNumber.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
                [btnNumber setTitle:@"重置" forState:UIControlStateNormal];//[btnNumber setTitle:@"重置" forState:UIControlStateNormal];
                [btnNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btnNumber addTarget:self action:@selector(resetTextWithButtonTag) forControlEvents:UIControlEventTouchUpInside];
                btnNumber.hidden = YES;
            } else if(i == 3 && j == 1){
                btnNumber.backgroundColor = [UIColor whiteColor];
                [btnNumber setTitle:@"0" forState:UIControlStateNormal];
                [btnNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btnNumber addTarget:self action:@selector(changeTextWithButtonTag:) forControlEvents:UIControlEventTouchUpInside];
            } else if(i == 3 && j == 2){
                btnNumber.backgroundColor = [UIColor clearColor];
                [btnNumber setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
                [btnNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btnNumber addTarget:self action:@selector(removeOneCharWithButtonTag:) forControlEvents:UIControlEventTouchUpInside];
            } else {
                btnNumber.backgroundColor = [UIColor whiteColor];
                [btnNumber setTitle:[NSString stringWithFormat:@"%d",i*3+j+1] forState:UIControlStateNormal];
                [btnNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btnNumber addTarget:self action:@selector(changeTextWithButtonTag:) forControlEvents:UIControlEventTouchUpInside];
            }
            [keyboardBg addSubview:btnNumber];
        }
    }
    
    //添加picc资金保障button
    _btnSecture = [[UIButton alloc]initWithFrame:CGRectMake(0, keyboardBg.frame.origin.y - 50, kScreenWidth ,40*kHeightRatio)];
    [_btnSecture setTitle:@" 账户资金安全由银行、新浪支付、PICC共同保障" forState:UIControlStateNormal];
    [_btnSecture setTitleColor:[UIColor colorWithRed:0.62 green:0.64 blue:0.65 alpha:1] forState:UIControlStateNormal];
    [_btnSecture setImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    _btnSecture.titleLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:_btnSecture];
}

/**
 *  修改label的text
 */
- (void)changeTextWithButtonTag:(UIButton *)sender{
    
    if (_password.length>=6) {
    
        return;
    }
    NSInteger index=sender.tag-1500;
    if (index==11) {
        index=0;
    }
    [_password appendString:[NSString stringWithFormat:@"%ld",(long)index]];
    
    UILabel *lblPwd =(UILabel*)[self  viewWithTag:1600 + lblTag];
    lblPwd.text = @"*";
    lblTag ++;
    if (_password.length==6) {
        if (self.pushMyBlock) {
            self.pushMyBlock(self.password);
        }
    }
}

/**
 *  重置label的text
 */
- (void)resetTextWithButtonTag{
    
    lblTag = 1;
    _password = [[NSMutableString alloc]init];
    for (int i = 0; i < 6; i ++) {
        
        UILabel *lblPwd =(UILabel*)[self  viewWithTag:1601 + i];
        lblPwd.text = @"";
        
    }
}

/**
 *  删除一个label的text
 */
- (void)removeOneCharWithButtonTag:(UIButton *)sender{
    
    if (_password.length>6 || _password.length<=0) {
        return;
    }
    [_password deleteCharactersInRange:NSMakeRange(_password.length - 1, 1)];
    UILabel *lblPwd =(UILabel*)[self  viewWithTag:1601 + _password.length];
    lblPwd.text = @"";
    lblTag --;
    
}


@end
