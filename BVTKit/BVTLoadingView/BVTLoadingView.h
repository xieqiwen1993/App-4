//
//  BVTLoadingView.h
//  ContactInformation
//
//  Created by Yooli on 11-8-10.
//  Copyright 2011年 Yooli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BVTLoadingViewDelegate <NSObject>
@optional
- (void)onLoadingCancelled:(NSUInteger)tag;
@end

@interface BVTLoadingView : UIView

- (void)setCancelImage:(UIImage *)cancelImage;

- (void)show:(NSString *)title cancelDelegate:(__weak id<BVTLoadingViewDelegate> )cancelDelegate tag:(NSUInteger)tag;
- (void)hide;

@end