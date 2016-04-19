//
//  RequestNetwork.m
//  AiYa
//
//  Created by longpeng on 14/11/5.
//  Copyright (c) 2014年 longpeng. All rights reserved.
//

#import "RequestNetwork.h"
#import "AFNetworking.h"
#import "AFURLConnectionOperation.h"
#import "NSObject+AFNetworking.h"


@implementation RequestNetwork
+ (instancetype)manager
{
    return [[self alloc] init];
}

/**
 *  获取网络数据
 *
 *  @param severAddress 请求地址
 *  @param dic          请求参数
 *  @param success      请求成功block
 *  @param failure      请求失败block
 */
- (void)postSeverAddress:(NSString *)severAddress
     parameters:(NSDictionary *)dic
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure
{

    //htts 允许无效协议
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    //htts 允许无效协议
    //    [manager setSecurityPolicy:securityPolicy];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型≥
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]initWithDictionary:dic];
    //拼接version\key\secret参数
    [parameter setValue:[ToolMethod getVersion] forKey:@"version"];
    [parameter setValue:kAppKey forKey:@"appkey"];
    [parameter setValue:kAppSecret forKey:@"appsecret"];
    [parameter setValue:@"methodname" forKey:@"methodname"];
    //给请求头添加参数
#pragma mark-----------delete 
    //[ToolMethod addInfoToRequestHeader:manager.requestSerializer];
    [manager POST:severAddress parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

//        if (error.code == NSURLErrorTimedOut || error.code ==NSURLErrorNotConnectedToInternet){
////            Alert0(@"您的网络不好哟，请稍后再试");
//        }
        
//        UIImageView *imgGolbalmaintenance = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//        imgGolbalmaintenance.image = [UIImage imageNamed:@"newwork_faile.jpg"];
//        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:imgGolbalmaintenance];
        
        //添加请求parameter和severAddress进dictionary 点击屏幕时循环调用请求方法重新加载
        
        failure(error);
    }];
}
-(void)postSeverAddressLx:(NSString *)severAddress parameters:(NSDictionary *)dic success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
   // NSString *str1=@"https://alpha-api.app.net/stream/0/posts/stream/global";

    NSString * getUserInfoServiceAdress = [NSString stringWithFormat:kServerUrl,@"product/appoint"];


    NSObject *ibj=[[NSObject alloc]init];
    
//    [ibj post:str1 parameters:nil timeout:NSTimeIntervalSince1970 success:^(id response) {
//        NSLog(@"success!");
//    } failure:^(YLError *error) {
//        NSLog(@"success!");
//    }];
    [ibj post:getUserInfoServiceAdress parameters:nil success:^(id response) {
        NSLog(@"success!");
    } failure:^(YLError *error) {
        NSLog(@"success!");
    }];
    
}

@end
