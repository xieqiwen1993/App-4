//
//  CellBgView.h
//  Yooli
//
//  Created by Yooli on 12/20/13.
//  Copyright (c) 2013 Yooli. All rights reserved.
//

#import <UIKit/UIKit.h>

enum SplitterAlignment
{
    SplitterAlignmentCenter,
    SplitterAlignmentLeft,
    SplitterAlignmentRight,
};


@interface CellBgView : UIView

@property (nonatomic) BOOL splitterOnTop;
@property (nonatomic) BOOL splitterOnBottom;
@property (nonatomic) CGFloat splitterIndentationTop;
@property (nonatomic) CGFloat splitterIndentationBottom;
@property (nonatomic) enum SplitterAlignment splitterAlignment;
@property (nonatomic, strong) UIColor *splitterColor;

@property (nonatomic) BOOL splitterHidden;
@property (nonatomic) CGFloat splitterLengthRatioTop;
@property (nonatomic) CGFloat splitterLengthRatio;

@end
