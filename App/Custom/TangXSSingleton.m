//
//  TangXSSingleton.m
//  TangXSLiCai
//
//  Created by homer on 15/5/29.
//  Copyright (c) 2015年 YXF. All rights reserved.
//

#import "TangXSSingleton.h"

@implementation TangXSSingleton

+(TangXSSingleton *)sharedInstance
{
    static TangXSSingleton *iYaoInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iYaoInstance = [[TangXSSingleton alloc] init];
    });
    return iYaoInstance;
}

/**
 *  是否是正常的金额
 *
 *  @return YES 表示正常
 */
- (BOOL)isPassMount:(NSString *)amount{
    
    //验证非0开头的数字
    NSString *phoneRegex = @"^([1-9][0-9]*)$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:amount];
    
}


@end
