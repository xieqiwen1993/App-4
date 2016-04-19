//
//  BVTToastView.h
//  Dragon
//
//  Created by Yooli on 12/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BVT_TOAST_VIEW_DISMISS)
{
    BVTToastViewDismissOptionAuto     = 0x01, // 显示0.5秒后自动消失
    BVTToastViewDismissOptionManual   = 0x02, // 手动点击屏幕消失
};

@interface BVTToastView : UIButton

// 显示文字text, backgroud为默认方式，dismissOption = BVTToastViewDismissOptionAuto|BVTToastViewDismissOptionManual
+ (void)show:(NSString *)text;

+ (void)show:(NSString *)text dismissOption:(NSInteger)dismissOption;

+ (void)show:(NSString *)text dismissOption:(NSInteger)dismissOption background:(UIImage *)image;


@end
