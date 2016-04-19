//
//  FindViewController.m
//  App
//
//  Created by Gaiminghui on 16/4/7.
//  Copyright © 2016年 company. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bacgroudView.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)shareClcik:(id)sender {
    BVTAlertView *alertView = [[BVTAlertView alloc] init];
    //alertView.delegate = blockify(self); // 这里用blockify(self)避免循环引用
    alertView.delegate=self;
    alertView.title = @"分享到：";
    alertView.message = @"朋友圈";
    alertView.cancelButtonTitle = @"取消";
    alertView.otherButtonTitles = @[@"分享"];
    alertView.cancelHandler = ^{
        NSLog(@"点击取消了");
    };
    alertView.dismissHandler = ^(NSUInteger index) {
        if (index == 0) {
            NSLog(@"点分享了");
            [self shareToWeichat];
        }
    };
    [alertView show];
    
//    //1、创建分享参数
//    NSArray* imageArray = @[[UIImage imageNamed:@"登录前"]];
//    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:@"分享内容"
//                                     images:imageArray
//                                        url:[NSURL URLWithString:@"http://mob.com"]
//                                      title:@"分享标题"
//                                       type:SSDKContentTypeAuto];
//
//    if (imageArray) {
//        
//        
//        [ShareSDK showShareActionSheet:nil
//                                 items:nil
//                           shareParams:shareParams
//                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                       
//                       switch (state) {
//                           case SSDKResponseStateSuccess:
//                           {
//                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                   message:nil
//                                                                                  delegate:nil
//                                                                         cancelButtonTitle:@"确定"
//                                                                         otherButtonTitles:nil];
//                               [alertView show];
//                               break;
//                           }
//                           case SSDKResponseStateFail:
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                               message:[NSString stringWithFormat:@"%@",error]
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"OK"
//                                                                     otherButtonTitles:nil, nil];
//                               [alert show];
//                               break;
//                           }
//                           default:
//                               break;
//                               
//                       }}];
//        
//    }
//
//    //无UI直接分享到微信
//    [ShareSDK share:22 parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//        
//    }];
    
}
-(void)shareToWeichat{
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"登录前"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"http://lixin360.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    
    
    
    //直接分享到微信
    
    [ShareSDK share:23 parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
                
        }
    }];
}
@end
