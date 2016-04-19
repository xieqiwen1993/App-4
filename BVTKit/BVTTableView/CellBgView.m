//
//  CellBgView.m
//  Yooli
//
//  Created by Yooli on 12/20/13.
//  Copyright (c) 2013 Yooli. All rights reserved.
//

#import "CellBgView.h"

#define LINE_H  (0.5f)

@implementation CellBgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.splitterOnTop = NO;
        self.splitterOnBottom = NO;
        self.splitterIndentationTop = 0.0f;
        self.splitterIndentationBottom = 0.0f;
        self.splitterAlignment = SplitterAlignmentCenter;
        self.splitterColor = [UIColor clearColor];
        
        self.splitterHidden = NO;
        self.splitterLengthRatio = 0.0f;
        self.splitterLengthRatioTop = 0.0f;
    }
    return self;
}

- (void)dealloc
{

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
    if (_splitterOnBottom == NO && _splitterOnTop == NO)
        return ;
    
    CGFloat x = rect.origin.x;
    CGFloat w = rect.size.width;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, LINE_H);
    CGContextSetStrokeColorWithColor(context, [_splitterColor CGColor]);
    
    if (_splitterOnTop)
    {
        if (_splitterAlignment == SplitterAlignmentRight)
        {
            x = _splitterIndentationTop;
            w -= _splitterIndentationTop;
        }
        else if (_splitterAlignment == SplitterAlignmentCenter)
        {
            x = _splitterIndentationTop;
            w -= 2*_splitterIndentationTop;
        }
        
        CGContextMoveToPoint(context, x, rect.origin.y+(LINE_H/2));
        CGContextAddLineToPoint(context, x+w, rect.origin.y+(LINE_H/2));
    }
    
    if (_splitterOnBottom)
    {
        if (_splitterAlignment == SplitterAlignmentRight)
        {
            x = _splitterIndentationBottom;
            w -= _splitterIndentationBottom;
        }
        else if (_splitterAlignment == SplitterAlignmentCenter)
        {
            x = _splitterIndentationBottom;
            w -= 2*_splitterIndentationBottom;
        }
        
        CGContextMoveToPoint(context, x, rect.origin.y+rect.size.height-(LINE_H/2));
        CGContextAddLineToPoint(context, x+w, rect.origin.y+rect.size.height-(LINE_H/2));
    }
    
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

- (void)setSplitterOnTop:(BOOL)splitterOnTop {
    _splitterOnTop = splitterOnTop;
    [self setNeedsDisplay];
}

- (void)setSplitterOnBottom:(BOOL)splitterOnBottom {
    _splitterOnBottom = splitterOnBottom;
    [self setNeedsDisplay];
}

- (void)setSplitterIndentationTop:(CGFloat)splitterIndentationTop {
    _splitterIndentationTop = splitterIndentationTop;
    [self setNeedsDisplay];
}

- (void)setSplitterIndentationBottom:(CGFloat)splitterIndentationBottom {
    
    _splitterIndentationBottom = splitterIndentationBottom;
    [self setNeedsDisplay];
}
/*
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (_splitterHidden)
        return;
    
    if (_splitterOnBottom == NO && _splitterOnTop == NO)
        return ;
    
    CGFloat x = rect.origin.x;
    CGFloat xt = rect.origin.x;
    CGFloat w = rect.size.width;
    CGFloat wt = rect.size.width;
    CGFloat y = rect.origin.y+rect.size.height-(LINE_H/2);
    
    if (_splitterLengthRatio != 1.0f)
        w *= _splitterLengthRatio;
    else
        w -= _splitterIndentation;
    
    if (_splitterLengthRatioTop != 1.0f)
        wt *= _splitterLengthRatioTop;
    else
        wt -= _splitterIndentationTop;
    
    
    if (_splitterAlignment == SplitterAlignmentRight)
    {
        x = rect.size.width-w;
        xt = rect.size.width-wt;
    }
    else if (_splitterAlignment == SplitterAlignmentCenter)
    {
        x = (rect.size.width-w)/2;
        xt = (rect.size.width-wt)/2;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, LINE_H);
    CGContextSetStrokeColorWithColor(context, [_splitterColor CGColor]);
    
    if (_splitterOnBottom)
    {
        CGContextMoveToPoint(context, x, y);
        CGContextAddLineToPoint(context, x+w, y);
    }
    
    if (_splitterOnTop)
    {
        CGContextMoveToPoint(context, xt, rect.origin.y+(LINE_H/2));
        CGContextAddLineToPoint(context, xt+wt, rect.origin.y+(LINE_H/2));
    }
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

- (void)setSplitterHidden:(BOOL)splitterHidden
{
    _splitterHidden = splitterHidden;
    [self setNeedsDisplay];
}

- (void)setSplitterAlignment:(enum SplitterAlignment)splitterAlignment
{
    _splitterAlignment = splitterAlignment;
    [self setNeedsDisplay];
}

- (void)setSplitterLengthRatio:(CGFloat)splitterLengthRatio
{
    _splitterLengthRatio = splitterLengthRatio;
    [self setNeedsDisplay];
}

- (void)setSplitterLengthRatioTop:(CGFloat)splitterLengthRatioTop
{
    _splitterLengthRatioTop = splitterLengthRatioTop;
    [self setNeedsDisplay];
}

- (void)setSplitterColor:(UIColor *)splitterColor
{
    _splitterColor = splitterColor;
    [self setNeedsDisplay];
}

- (void)setSplitterOnTop:(BOOL)splitterOnTop
{
    _splitterOnTop = splitterOnTop;
    [self setNeedsDisplay];
}
 */

@end
