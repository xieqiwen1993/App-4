
#ifndef App_Defines_h
#define App_Defines_h

#pragma mark - Data

#define DEFAULT_USERID      0

#pragma mark - Frame & Bound

#define FRAME_L(view) (view.frame.origin.x)
#define FRAME_R(view) (view.frame.origin.x+view.frame.size.width)
#define FRAME_T(view) (view.frame.origin.y)
#define FRAME_B(view) (view.frame.origin.y+view.frame.size.height)
#define FRAME_W(view) (view.frame.size.width)
#define FRAME_H(view) (view.frame.size.height)

#pragma  mark----------gaiminghui
#import "BVTKit.h"
#import "BVTDefines.h"
#import "ToolMethod.h"

#import "AFNetworkReachabilityManager.h"
#import "RequestNetwork.h"
#import "AFNetworking.h"
#import "TangXSSingleton.h"

#import "NSObject+AFNetworking.h"
//百度地图
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
//分享
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"


//y用户头像
#define kUserImage @"userimage"
//用户登录信息
#define kAccessToken @"accesstoken"
//父级分类数据
#define kParentCategory @"parentCategory"
//子级分类数据
#define kChildCategory @"childCategory"
//子级分类数据
#define kSharkText @"快来和【唐小僧】一起体验高收益理财吧"
//商户Id
#define kStoreId @"storeId"
//最近选择的城市
#define kRecentlyCityModel @"recentlyCityModel"
//是否是第一次使用
#define kIsFirstUse @"isFirstUse"
//是否关闭声音
#define kIsCloseSound @"isCloseSound"
//是否关闭震动
#define kIsCloseVibration @"isCloseVibration"
//是否关闭震动
#define kIsCloseLock @"isCloseLock"

//是否记录手势密码
#define kIsOpenGesturePassword @"isOpenGesturePassword"

// 记录app从台进入前端
#define GestureFromBackground @"appFromBackground"

//是否第一次登陆
#define kIsFirstLog @"isFirstLog"



#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kLabelFont(_label_,_x_) _label_.font=[UIFont systemFontOfSize:_x_];
#define  RGBA(r,g,b,a)[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kTagW1 10000
#define kTagW2 20000
#define kTagW3 30000
#define kTagW4 40000
#define kTagW5 50000
#define kTagQ1 1000
#define kTagQ2 2000
#define kTagQ3 3000
#define kTagQ4 4000
#define kTagQ5 5000
#define kWidthRatio kScreenWidth/1242
#define kHeightRatio kScreenHeight/2208
#define kHeightRatioFrame kScreenHeight/2208+64
#define kFontSize kScreenWidth/414




//测试服务器 网络请求地址
//#define kServerUrl @"http://192.168.3.10:3459/v2/app.svc/%@"
#define kAppKey @"8AD5B22C-47CE-4FC6-8DE1-F61D97900709"
#define kAppSecret @"44E64145-7D9E-4387-A6AB-02A6636D5F30"
//测试服务器
#define kServerUrl @"http://120.55.179.185/v2/app.svc/%@"// http://192.168.3.152:8029/v2/app.svc/  http://120.55.179.185/v2/app.svc/%@
//测试分享地址
#define kSharkUrl @"http://tservice.txslicai.com/Html/Anonymous/wap.html"
//合同模板
#define kContract @"http://tservice.txslicai.com/Html/Product/regular-template-list.html"
//注册协议
#define kRegisterProtocol @"http://tservice.txslicai.com/Html/Anonymous/register-protocol.html"
//商户地址在地图中展示
#define kStoreAddressURL @"http://tservice.txslicai.com/html/store/commercialMapAddress.html"
//邀请好友的链接下载地址
#define kSharkLinkURL @"http://tservice.txslicai.com/html/my/qujin-invite.html"
//我要取金的链接下载地址
#define kMoneyLinkURL @"http://tservice.txslicai.com/Html/My/qujin.html"



#pragma  mark----------gaiminghui




#define BOUND_L(view) (view.bounds.origin.x)
#define BOUND_R(view) (view.bounds.origin.x+view.bounds.size.width)
#define BOUND_T(view) (view.bounds.origin.y)
#define BOUND_B(view) (view.bounds.origin.y+view.bounds.size.height)
#define BOUND_W(view) (view.bounds.size.width)
#define BOUND_H(view) (view.bounds.size.height)

#pragma mark - App 版本号

#define YOOLI_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#pragma mark - 设备相关

#define DEVICE_NAME         [[UIDevice currentDevice] name]
#define DEVICE_MODEL        [[UIDevice currentDevice] model]
#define IOS_VERSION_STRING  [[UIDevice currentDevice] systemVersion]
#define IOS_VERSION_FLOAT   [[[UIDevice currentDevice] systemVersion] floatValue]

#pragma mark - 判断指针是否为空

#define IS_NULL(x)  (x==nil || [x isKindOfClass:[NSNull class]])

#pragma mark - 从dictionary中取对象
#define OBJECTFORKEY(dic, key) ((IS_NULL(dic)||![dic isKindOfClass:[NSDictionary class]]||IS_NULL([dic objectForKey:key]))?nil:[dic objectForKey:key])

#endif
