//
//  NSObject+AFNetworking.h
//  YooliConcept
//
//  Created by Yooli on 14-12-25.
//  Copyright (c) 2014年 Yooli.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 网络错误类
 */
typedef NS_ENUM(NSInteger, YLErrorCode) {
	YLErrorCodeUnknown = -1,
	YLErrorCodeTimedOut,
	YLErrorCodeCannotConnectToHost
};

extern NSString *const YLErrorMsgUnknown;
extern NSString *const YLErrorMsgTimedOut;
extern NSString *const YLErrorMsgCannotConnectToHost;

@interface YLError : NSObject

@property(nonatomic, assign) YLErrorCode code;
@property(nonatomic, strong) NSString *msg;

- (id)initWithCode:(YLErrorCode)code msg:(NSString *)msg;

@end

/**
 * 上传的附件类
 */
@interface YLAttachment : NSObject

@property(nonatomic, strong) NSURL *fileUrl;
@property(nonatomic, strong) NSData *fileData;
@property(nonatomic, strong) NSString *fileName;
@property(nonatomic, strong) NSString *mimeType;
@property(nonatomic, strong) NSString *name;		// key name
@property(nonatomic, strong) NSString *md5;

@end

/**
 * 如果modelClass为nil，则返回的response为dictionary
 * 否则，为对应类的实例
 */
@interface NSObject (AFNetworking)

- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
     success:(void (^)(id response))success
     failure:(void (^)(YLError *error))failure;

- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
	 timeout:(NSTimeInterval)timeout
	 success:(void (^)(id response))success
	 failure:(void (^)(YLError *error))failure;

// 上传用这个
- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
 attachments:(NSArray *)attachments		// NSArray<YLAttachment *>
	progress:(void (^)(float))progress
     success:(void (^)(id response))success
     failure:(void (^)(YLError *error))failure;

// 下载用这个
- (void)download:(NSString *)urlString
        progress:(void (^)(float))progress
         success:(void (^)(id))success
         failure:(void (^)(YLError *))failure;

/*
- (void)get:(NSString *)urlString
 parameters:(NSDictionary *)parameters
 modelClass:(Class)modelClass
	success:(void (^)(id response))success
	failure:(void (^)(YLError *error))failure;

- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
  modelClass:(Class)modelClass
	 success:(void (^)(id response))success
	 failure:(void (^)(YLError *error))failure;

// 上传用这个
- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
 attachments:(NSArray *)attachments		// NSArray<YLAttachment *>
  modelClass:(Class)modelClass
     success:(void (^)(id response))success
     failure:(void (^)(YLError *error))failure;

// 下载用这个
- (void)download:(NSString *)urlString
		progress:(void (^)(float))progress
		 success:(void (^)(id))success
		 failure:(void (^)(YLError *))failure;
 */

// 大多数情况下不需要调用此方法，当对象被销毁时会自动取消所有请求
- (void)cancelAllRequests;

@end
