//
//  TangXSSingleton.h
//  TangXSLiCai
//
//  Created by homer on 15/5/29.
//  Copyright (c) 2015年 YXF. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MyWelfareModel.h"

@interface TangXSSingleton : NSObject

+ (TangXSSingleton *)sharedInstance;

/**
 *  用户信息
 */
//@property (nonatomic, retain)MyWelfareModel *userInfoModel;
//用户头像
@property(nonatomic,strong)UIImage *userImag;

/**
 *  用户token
 */
@property (nonatomic, retain)NSString *userAccessToken;

/**
 *  纬度（小于90）
 */
@property (nonatomic, copy)NSString *latitude;

/**
 *  经度
 */
@property (nonatomic, copy)NSString *longitude;

/**
 *  用于push和返回的controller
 */
@property(nonatomic,strong)NSMutableArray *arrTempViewController;

/**
 *  是否选择城市
 */
@property(nonatomic,assign)BOOL isChooseCity;

/**
 *  是否显示距离
 */
@property(nonatomic,assign)BOOL isShowDistence;

/**
 *  充值入口
 *  1：活期购买 
 *  2：定期购买 
 *  3: 我的首页
 */
@property(nonatomic)NSInteger rechargeProt;

/**
 *  定期购买页面的view
 */
@property(nonatomic,retain)UIView *viewInvesmentRed;

/**
 *  是否是正常的金额 非0开头的数字
 *
 *  @return YES 表示正常
 */
- (BOOL)isPassMount:(NSString *)amount;

@end
