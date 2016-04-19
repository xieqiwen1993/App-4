//
//  NSObject+AFNetworking.m
//  YooliConcept
//
//  Created by Yooli on 14-12-25.
//  Copyright (c) 2014年 Yooli.com. All rights reserved.
//

#import "NSObject+AFNetworking.h"
#import <objc/runtime.h>
#import "AFNetworking.h"
#import "JSONModel.h"

/**
 * 网络错误类
 */
NSString *const YLErrorMsgUnknown = @"未知错误";
NSString *const YLErrorMsgTimedOut = @"请求超时";
NSString *const YLErrorMsgCannotConnectToHost = @"无法连接到服务器";

@implementation YLError

- (id)initWithCode:(YLErrorCode)code msg:(NSString *)msg
{
	self = [super init];
	if (self) {
		_code = code;
		_msg = msg;
	}
	return self;
}

@end

/**
 * 上传的附件类
 */
@implementation YLAttachment

@end

/**
 * 请求的关联对象
 */
@interface YLRequestAssociation : NSObject

@property(nonatomic, strong) NSMutableArray *requests;

@end

@implementation YLRequestAssociation

- (id)init
{
	self = [super init];
	if (self) {
		_requests = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)addRequest:(AFHTTPRequestOperation *)request
{
	if (![self.requests containsObject:request])
		[self.requests addObject:request];
}

- (void)removeRequest:(AFHTTPRequestOperation *)request
{
	if ([self.requests containsObject:request]) {
		if ([request isExecuting])
			[request cancel];
		[self.requests removeObject:request];
	}
}

- (void)removeAllRequests
{
	for (AFHTTPRequestOperation *request in self.requests) {
		if ([request isExecuting])
			[request cancel];
	}
	[self.requests removeAllObjects];
}

- (void)dealloc
{
	[self removeAllRequests];
}

@end

static void *associationKey;

@implementation NSObject (AFNetworking)

- (YLRequestAssociation *)associatedObject
{
	id obj = objc_getAssociatedObject(self, &associationKey);
	if (obj == nil) {
		obj = [[YLRequestAssociation alloc] init];
		objc_setAssociatedObject(self, &associationKey, obj, OBJC_ASSOCIATION_RETAIN);
	}
	return obj;
}

+ (AFSecurityPolicy *)securityPolicy
{
	AFSecurityPolicy *sp = [AFSecurityPolicy defaultPolicy];
#ifdef DEBUG
	sp.allowInvalidCertificates = YES;
	sp.validatesDomainName = NO;
    sp.validatesCertificateChain = NO;
#else
	sp.allowInvalidCertificates = NO;
	sp.validatesDomainName = YES;
    sp.validatesCertificateChain = YES;
#endif
	return sp;
}

+ (AFHTTPRequestOperationManager *)apiManager
{
	static AFHTTPRequestOperationManager *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		manager = [AFHTTPRequestOperationManager manager];
		NSSet *contentTypes = manager.responseSerializer.acceptableContentTypes;
		NSMutableSet *set = [NSMutableSet setWithSet:contentTypes];
		[set addObject:@"text/plain"];
		manager.responseSerializer.acceptableContentTypes = set;
		manager.requestSerializer.timeoutInterval = 20;
		manager.securityPolicy = [NSObject securityPolicy];
	});
	return manager;
}

+ (AFHTTPRequestOperationManager *)downloadManager
{
	static AFHTTPRequestOperationManager *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		manager = [AFHTTPRequestOperationManager manager];
		manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
		manager.requestSerializer.timeoutInterval = 60;
		manager.securityPolicy = [NSObject securityPolicy];
	});
	return manager;
}

/*
- (void)doSuccess:(AFHTTPRequestOperation *)req response:(id)response modelClass:(Class)modelClass success:(void (^)(id))success
{
	YLRequestAssociation *obj = [self associatedObject];
	[obj removeRequest:req];
	
	if (success) {
		if (modelClass) {
			NSError *error = nil;
			id model = [[modelClass alloc] initWithDictionary:response error:&error];
			success(model);
			if (error)
				NSLog(@"%@", error);
		} else {
			success(response);
		}
	}
}
*/

- (void)doSuccess:(AFHTTPRequestOperation *)req response:(id)response success:(void (^)(id))success
{
    YLRequestAssociation *obj = [self associatedObject];
    [obj removeRequest:req];
    
    if (success) {
        success(response);
    }
}

- (void)doError:(AFHTTPRequestOperation *)req error:(NSError *)error failure:(void (^)(YLError *))failure
{
	YLRequestAssociation *obj = [self associatedObject];
	[obj removeRequest:req];
	
	if (failure) {
		switch (error.code) {
			case NSURLErrorCancelled:
				NSLog(@"主动取消请求");
				break;
			case NSURLErrorTimedOut: {
				YLError *err = [[YLError alloc] initWithCode:YLErrorCodeTimedOut msg:YLErrorMsgTimedOut];
				failure(err);
				break;
			}
			case NSURLErrorCannotConnectToHost: {
				YLError *err = [[YLError alloc] initWithCode:YLErrorCodeCannotConnectToHost msg:YLErrorMsgCannotConnectToHost];
				failure(err);
				break;
			}
			default: {
				YLError *err = [[YLError alloc] initWithCode:YLErrorCodeUnknown msg:YLErrorMsgUnknown];
				failure(err);
				break;
			}
		}
	}
}

- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
     success:(void (^)(id))success
     failure:(void (^)(YLError *))failure
{
	[self post:urlString parameters:parameters timeout:20 success:success failure:failure];
}

- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
	 timeout:(NSTimeInterval)timeout
	 success:(void (^)(id))success
	 failure:(void (^)(YLError *))failure
{
	__weak typeof(self) weakSelf = self;
	AFHTTPRequestOperationManager *manager = [NSObject apiManager];
	manager.requestSerializer.timeoutInterval = timeout;
	AFHTTPRequestOperation *req = [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		
		[weakSelf doSuccess:operation response:responseObject success:success];
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		
		[weakSelf doError:operation error:error failure:failure];
		
	}];
	YLRequestAssociation *obj = [self associatedObject];
	[obj addRequest:req];
}

- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
 attachments:(NSArray *)attachments
	progress:(void (^)(float))progress
     success:(void (^)(id))success
     failure:(void (^)(YLError *))failure
{
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperation *req = [[NSObject apiManager] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (YLAttachment *a in attachments) {
            NSError *error = nil;
            if (a.fileUrl)
                [formData appendPartWithFileURL:a.fileUrl name:a.name fileName:a.fileName mimeType:a.mimeType error:&error];
            else if (a.fileData)
                [formData appendPartWithFileData:a.fileData name:a.name fileName:a.fileName mimeType:a.mimeType];
            if (error)
                NSLog(@"%@", error);
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf doSuccess:operation response:responseObject success:success];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf doError:operation error:error failure:failure];
    }];
	[req setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
		if (progress)
			progress(totalBytesWritten*1.0/totalBytesExpectedToWrite);
	}];
    YLRequestAssociation *obj = [self associatedObject];
    [obj addRequest:req];
}

- (void)download:(NSString *)urlString
        progress:(void (^)(float))progress
         success:(void (^)(id))success
         failure:(void (^)(YLError *))failure
{
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperation *req = [[NSObject downloadManager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf doSuccess:operation response:responseObject success:success];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf doError:operation error:error failure:failure];
    }];
    [req setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        if (progress)
            progress(totalBytesRead*1.0/totalBytesExpectedToRead);
    }];
    YLRequestAssociation *obj = [self associatedObject];
    [obj addRequest:req];
}

/*
- (void)get:(NSString *)urlString
 parameters:(NSDictionary *)parameters
 modelClass:(Class)modelClass
	success:(void (^)(id))success
	failure:(void (^)(YLError *))failure
{
	__weak typeof(self) weakSelf = self;
	AFHTTPRequestOperation *req = [[NSObject apiManager] GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		[weakSelf doSuccess:operation response:responseObject modelClass:modelClass success:success];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[weakSelf doError:operation error:error failure:failure];
	}];
	YLRequestAssociation *obj = [self associatedObject];
	[obj addRequest:req];
}

- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
  modelClass:(Class)modelClass
	 success:(void (^)(id))success
	 failure:(void (^)(YLError *))failure
{
	__weak typeof(self) weakSelf = self;
	AFHTTPRequestOperation *req = [[NSObject apiManager] POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		[weakSelf doSuccess:operation response:responseObject modelClass:modelClass success:success];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[weakSelf doError:operation error:error failure:failure];
	}];
	YLRequestAssociation *obj = [self associatedObject];
	[obj addRequest:req];
}

- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
 attachments:(NSArray *)attachments
  modelClass:(Class)modelClass
	 success:(void (^)(id))success
	 failure:(void (^)(YLError *))failure
{
	__weak typeof(self) weakSelf = self;
	AFHTTPRequestOperation *req = [[NSObject apiManager] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
		for (YLAttachment *a in attachments) {
			NSError *error = nil;
            if (a.fileUrl)
                [formData appendPartWithFileURL:a.fileUrl name:a.name fileName:a.fileName mimeType:a.mimeType error:&error];
            else if (a.fileData)
                [formData appendPartWithFileData:a.fileData name:a.name fileName:a.fileName mimeType:a.mimeType];
            if (error)
                NSLog(@"%@", error);
		}
	} success:^(AFHTTPRequestOperation *operation, id responseObject) {
		[weakSelf doSuccess:operation response:responseObject modelClass:modelClass success:success];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[weakSelf doError:operation error:error failure:failure];
	}];
	YLRequestAssociation *obj = [self associatedObject];
	[obj addRequest:req];
}

- (void)download:(NSString *)urlString
		progress:(void (^)(float))progress
		 success:(void (^)(id))success
		 failure:(void (^)(YLError *))failure
{
	__weak typeof(self) weakSelf = self;
	AFHTTPRequestOperation *req = [[NSObject downloadManager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		[weakSelf doSuccess:operation response:responseObject modelClass:NULL success:success];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[weakSelf doError:operation error:error failure:failure];
	}];
	[req setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
		if (progress)
			progress(totalBytesRead*1.0/totalBytesExpectedToRead);
	}];
	YLRequestAssociation *obj = [self associatedObject];
	[obj addRequest:req];
}
 */

- (void)cancelAllRequests
{
	YLRequestAssociation *obj = [self associatedObject];
	[obj removeAllRequests];
}

@end
