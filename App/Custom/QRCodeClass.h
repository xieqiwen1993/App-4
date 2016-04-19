//
//  QRCodeClass.h
//  Demo
//
//  Created by homer on 15/11/5.
//  Copyright © 2015年 homer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QRCodeClass : NSObject

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size ;
+ (CIImage *)createQRForString:(NSString *)qrString ;
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue ;

@end
