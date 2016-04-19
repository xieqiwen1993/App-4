//
//  ToolMethod.h
//  Txs2.0Page
//
//  Created by homer on 15/9/14.
//  Copyright (c) 2015年 homer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CuntdownAlertView.h"
//#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "UIDeviceHardware.h"


@interface ToolMethod : NSObject

//{
//    AppDelegate *_delegate;
//}


/**
 *  画一条横的直线
 *
 *  @param frame  直线frame
 *  @param bgView superView
 */
+ (void)drawLineWithFrame:(CGRect)frame SuperView:(UIView *)bgView;

+ (void)drawLineWithFrame:(CGRect)frame SuperView:(UIView *)bgView LineColor:(UIColor *)lineColor;

//手机号格式判断
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

//身份证验证
+ (BOOL)isidCardNumber:(NSString *)idCard;

//验证码判断
+ (BOOL)isVerificationCode:(NSString *)Code;

/**
 *  将数字以逗号分割
 */
+ (NSString *)numberDivision:(NSString *)number appendString:(NSString *)otherString;

/**
 *  是否是正常的两位小数的金额
 *
 *  @return YES 表示正常
 */
+ (BOOL)isPassMount:(NSString *)amount;

/**
 *  是否是大于0的金额
 *
 *  @return YES 表示正常
 */
+ (BOOL)isAmountMoreThenZero:(NSString *)amount;

/**
 *  是否是纯数字
 *
 *  @param stringText
 *
 *  @return
 */
+ (BOOL)isAllNumber:(NSString *)stringText;

/**
 *  是否是纯数字
 *
 *  @param stringText
 *
 *  @return
 */
+ (BOOL)isNumber:(NSString *)stringText;

/**
 *  动态计算行高
 */
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;

/**
 *  计算两点距离
 *
 *  @param selfLatitude   自己的经度
 *  @param longitude      自己的纬度
 *  @param otherLatitude  别人经度
 *  @param otherLongitude 别人的纬度
 *
 *  @return 返回距离
 */
+ (NSString *)calculationDistanceWithSelfLatitude:(NSString *)selfLatitude SelfLongitude:(NSString *)longitude OtherLatitude:(NSString *)otherLatitude OtherLongitude:(NSString *)otherLongitude;

/**
 *  @author homer, 15-11-09
 *
 *  设置导航栏title
 */
+ (void)settingNavbarTitle:(UIViewController *)viewController ForString:(NSString *)titleStr;

/**
 *  @author homer, 15-11-09
 *
 *  设置导航栏title
 */
+ (void)settingNavbarTitle:(UIViewController *)viewController ForString:(NSString *)titleStr IsCanBack:(BOOL)isAddBack;

/**
 *  添加公司名字
 *
 *  @param supview superview
 */
+ (void)addCompanyNameWithSuperView:(UIView *)supview;

/**
 *  未登录 去登录
 *
 *  @param viewController viewController
 */
+ (void)toLoginPage:(UIViewController *)viewController;

/**
 *  未登录 去登录
 *
 *  @param viewController viewController
 *  @param FromPage push前进入的页面 //push进来的页面 1我的（未登陆） 2修改手机号
 */
+ (void)toLoginPage:(UIViewController *)viewController FromPage:(NSInteger)fromPage;

/**
 *  获取个人信息
 */
+ (void)getUserInfo:(void(^)())SuccessBlock;

/**
 *  转化成正确的字符串格式
 */

+(NSString *)getStringContent:(NSString *) contentStr;

/**
 *  给imgview设置类目图标
 *
 *  @param storeCateStr category
 *  @param imgview      imgView
 */
+ (void)setImageWithCategory:(NSString *)storeCateStr ContentImageView:(UIImageView *)imgview;

/**
 *  创建label
 */
+ (UILabel *)creatLabelWithFrame:(CGRect)frame  text:(NSString *)text ;

/**
 *  创建button可以创建 标题按钮和 图片按钮
 */
+ (UIButton *)creatButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)name title:(NSString *)title;


/**
 *  字符串保留小数点后2位
 */
+(NSString *)nsstringFormat:(NSString *)str;


+(void)pushNewView:(UIViewController *)Vc pushIndex:(NSInteger)index;

/**
 *  给cell添加“元”
 *
 *  @param view label的背景view
 */
+ (void)addLabelWithSuperView:(UIView *)view;

/**
 *  获取版本号
 *
 *  @return 返回版本号
 */
+ (NSString *)getVersion;

/**
 *  在请求头添加参数
 *
 *  @param serializer serializer
 */
//+ (void)addInfoToRequestHeader:(AFHTTPRequestSerializer *)serializer;

/**
 *  点击屏幕底部资金保障.....跳转PICC页面
 *
 *  @param viewController 当前viewController
 *  @param hideTabbar     是否隐藏tabbar
 */
+ (void)toPICCPage:(UIViewController *)viewController IsHideTabbar:(BOOL)hideTabbar;

/**
 *  拼接地址
 *
 *  @param model 数据model
 */
//+ (NSString *)getAddressByModel:(MyWelfareModel *)model;

/**
 *  退出时清除默认的NSUserDefaults数据
 */
+ (void)clearDataWhenLogOut;

/**
 *  计算项目金额 能整除的显示整数 不能整除的显示小数 如10000=1（万） 1＝0.0001（万）
 *
 *  @param strAmount 项目金额
 *
 *  @return 返回结果
 */
+ (NSString *)getProductAmountWithString:(NSString *)strAmount;

/**
 *  设置默认地址
 */
+ (void)setDefaultAddress;

@end
