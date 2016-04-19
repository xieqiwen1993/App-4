//
//  BVTIndicatorView.h
//  Yooli
//
//  Created by Yooli on 7/1/14.
//  Copyright (c) 2014 Yooli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BVTIndicatorView : UIView

- (void)startAnimating;
- (void)stopAnimating;

@property (nonatomic) CGFloat ratio;
@property (nonatomic, strong) UIColor *color;

@end
