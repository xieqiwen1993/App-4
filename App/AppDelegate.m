//
//  AppDelegate.m
//  App
//
//  Created by zhaoxm on 16/3/30.
//  Copyright © 2016年 company. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TabBarViewController.h"
#import "GuidViewController.h"

//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //判断是不是第一次启动应用
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
            {
                     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
                     NSLog(@"第一次启动");
                     //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
                     GuidViewController *userGuideViewController = [[GuidViewController alloc] init];
                     self.window.rootViewController = userGuideViewController;
                
        }
         else
             {
                     NSLog(@"不是第一次启动");
                     //如果不是第一次启动的话,使用LoginViewController作为根视图
                 TabBarViewController *vc = [[TabBarViewController alloc] init];
                 self.window.rootViewController = vc;
             
                 }
    //百度地图
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"04YpjaKlznT65B3APhaNZR97wRYXzG80"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    

    //[self shareSDKRegisterApp];
    [ShareSDK registerApp:@"11c53e9b07525"
     
          activePlatforms:@[
                            //@(SSDKPlatformTypeSinaWeibo),
//                            @(SSDKPlatformTypeMail),
//                            @(SSDKPlatformTypeSMS),
//                            @(SSDKPlatformTypeCopy),
                            //@(SSDKPlatformTypeWechat),
                          //  @(SSDKPlatformTypeQQ),
//                            @(SSDKPlatformTypeRenren),
//                            @(SSDKPlatformTypeGooglePlus)
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
            
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"1762677693"
                                           appSecret:@"dc2bd8f75dc1a5d6ef4216ba06aad6c1"
                                         redirectUri:@"http://lixin360.com"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
            case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeRenren:
                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                               authType:SSDKAuthTypeBoth];
                 break;
            
             default:
                 break;
         }
     }];

//    GuidViewController *userGuideViewController = [[GuidViewController alloc] init];
//    self.window.rootViewController = userGuideViewController;
//
    
    [self.window makeKeyAndVisible];
    
    

    return YES;
}
- (void)shareSDKRegisterApp{
    [ShareSDK registerApp:@"11c53e9b07525"
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                          
                            @(SSDKPlatformTypeWechat)]
     
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
//             case SSDKPlatformTypeQQ:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                 break;
//             case SSDKPlatformTypeSinaWeibo:
//                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                 break;
           
             default:
             break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"1762677693"
                                           appSecret:@"dc2bd8f75dc1a5d6ef4216ba06aad6c1"
                                         redirectUri:@"http://lixin360.com"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;

                 
         }
     }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
