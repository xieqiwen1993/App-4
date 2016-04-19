//
//  BVTBadge.h
//  App
//
//  Created by Yooli on 15-5-11.
//  Copyright (c) 2015年 yooli. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * 显示一个小红点
 */

@interface BVTBadge : UIView

// 设置小红点的直径
@property (nonatomic, assign) double diameter;

// 返回一个BVTBadge实例
+ (instancetype)badge;

// 设置小红点中心的位置
- (void)setOrigin:(CGPoint)origin;

@end
