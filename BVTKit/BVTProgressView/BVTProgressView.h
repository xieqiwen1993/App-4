//
//  BVTProgressView.h
//  Yooli
//
//  Created by Yooli on 7/9/14.
//  Copyright (c) 2014 Yooli.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BVTProgressView : UIView

/**
 * @property(nonatomic) CGRect            frame; //通过frame属性设置位置，大小
 */

@property (nonatomic, assign) double progress;

@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, strong) UIColor *trackColor;

@end
