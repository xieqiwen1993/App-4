//
//  RequestNetwork.h
//  AiYa
//
//  Created by longpeng on 14/11/5.
//  Copyright (c) 2014年 longpeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RequestNetwork : NSObject
+ (instancetype)manager;

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
             failure:(void (^)(NSError *error))failure;


- (void)postSeverAddressLx:(NSString *)severAddress
              parameters:(NSDictionary *)dic
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;



@end
