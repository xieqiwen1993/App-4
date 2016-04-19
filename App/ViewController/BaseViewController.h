//
//  BaseViewController.h
//  TangXSLiCai
//
//  Created by homer on 15/6/5.
//  Copyright (c) 2015年 YXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

//此类作为父类
@interface BaseViewController : UIViewController
@property(nonatomic,strong)MBProgressHUD *HUD;

//显示网络请求进度条
-(void)showProgress;

//隐藏进度条
- (void)hideProgress;

/**
 *  显示一则消息 自动隐藏
 */
- (void)showPropt:(NSString *)message;
/**
 *  显示错误消息
 *
 *  @param response     返回的数据
 *  @param otherMessage errorMsg为空时显示内容
 */
- (void)showErrorMsgWithResponse:(id)response
                        OtherMsg:(NSString *)otherMessage;

/**
 *  显示错误消息
 *
 *  @param response     返回的数据
 *  @param otherMessage errorMsg为空时显示内容
 */
- (void)showErrorMsgWithResponse:(id)response
                        OtherMsg:(NSString *)otherMessage
                  IsShowOtherMsg:(BOOL)isShow;

///**
// *  添加返回按钮
// */
//- (void)addBackButton:(UIViewController *)viewController;


@end
