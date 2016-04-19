//
//  AppDelegate.h
//  App
//
//  Created by zhaoxm on 16/3/30.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    //UIWindow *window;
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong) UIImageView *myTabar;


@end

