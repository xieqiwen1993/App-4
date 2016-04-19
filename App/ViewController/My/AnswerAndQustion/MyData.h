//
//  MyData.h
//  App
//
//  Created by Gaiminghui on 16/4/15.
//  Copyright © 2016年 company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyData : NSObject
{
    NSMutableArray *_array;// 每组的数据
    BOOL _isShow;// 组的状态，yes显示组，no不显示组
    NSString *_name;// 组名
}
@property (nonatomic,assign) BOOL isShow;
@end
