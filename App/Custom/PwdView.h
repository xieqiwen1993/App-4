//
//  PwdView.h
//  TangXSLiCai
//
//  Created by homer on 15/8/13.
//  Copyright (c) 2015年 YXF. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  密码输入完成时执行block
 *
 *  @param passwordText 输入完成的密码
 */
typedef void (^pushBlock)(NSString *passwordText);

/**
 *  点击取消时执行block
 *
 *  @param passwordText 输入完成的密码
 */
typedef void (^popBlock)(NSString *passwordText);

@interface PwdView : UIView

/**
 *  密码
 */
@property(nonatomic,strong)NSMutableString *password;

/**
 *  密码输入完成时执行block
 */
@property(nonatomic,copy)pushBlock pushMyBlock;

/**
 *  点击取消时执行block
 */
@property(nonatomic,copy)popBlock popMyBlock;

//添加picc资金保障button
@property(nonatomic,retain)UIButton *btnSecture;

/**
 *  初始化
 *
 *  @param frame frame
 *
 *  @return 返回值
 */
-(id)initWithFrame:(CGRect)frame Type:(BOOL)viewType;

-(void)showWithPush:(pushBlock)block;

-(void)showWithPop:(popBlock)block;

/**
 *  重置label的text
 */
- (void)resetTextWithButtonTag;



@end
