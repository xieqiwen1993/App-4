//
//  BVTIndicatorView.m
//  Yooli
//
//  Created by Yooli on 7/1/14.
//  Copyright (c) 2014 Yooli. All rights reserved.
//

#import "BVTIndicatorView.h"

#define MAX_STAGE       12
#define CIRCLE_RATIO    3.0f/4.0f

@interface BVTIndicatorView ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) int stage;

@end

@implementation BVTIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        _stage = 0;
    }
    return self;
}

- (void)dealloc
{
    [_timer invalidate];
}

- (void)startAnimating
{
    if (![self.timer isValid])
    {
        self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
        [self.timer fire];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    self.hidden = NO;
    
    _stage = MAX_STAGE*(1-CIRCLE_RATIO)+1;
}

- (void)stopAnimating
{
    [self.timer invalidate];
    self.hidden = YES;
}

- (void)setRatio:(CGFloat)ratio
{
    if ([self.timer isValid])
        return;
    
    self.hidden = NO;
    
    if (ratio > 1)
        _ratio = 1;
    else if (ratio < 0)
        _ratio = 0;
    else
        _ratio = ratio;
    
    [self setNeedsDisplay];
}

- (UIColor *)getColorForStage:(int)currentStage alpha:(double)alpha
{
    return self.color==nil ? [UIColor colorWithWhite:33.0f/255.0f alpha:alpha] : [self.color colorWithAlphaComponent:alpha];
}

- (CGPoint)pointOnInnerCirecleWithStage:(int)stage maxStage:(int)maxStage
{
    double r = self.frame.size.height/2/2;
    double cx = self.frame.size.width/2;
    double cy = self.frame.size.height/2;
    double x = cx + r*sin(M_PI*2/maxStage*stage);
    double y = cy - r*cos(M_PI*2/maxStage*stage);
    return CGPointMake(x, y);
}

- (CGPoint)pointOnOuterCirecleWithStage:(int)stage maxStage:(int)maxStage
{
    double r = self.frame.size.height/2;
    double cx = self.frame.size.width/2;
    double cy = self.frame.size.height/2;
    double x = cx + r*sin(M_PI*2/maxStage*stage);
    double y = cy - r*cos(M_PI*2/maxStage*stage);
    return CGPointMake(x, y);
}

- (void)drawRect:(CGRect)rect
{
    if ([self.timer isValid])
    {
        CGPoint point;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(ctx, 2.0);
        
        for (int i=0 ; i<MAX_STAGE*CIRCLE_RATIO; i++)
        {
            CGContextSetStrokeColorWithColor(ctx, [[self getColorForStage:_stage+i alpha:1.0f/(MAX_STAGE*CIRCLE_RATIO)*i] CGColor]);
            point = [self pointOnOuterCirecleWithStage:_stage+i maxStage:MAX_STAGE];
            CGContextMoveToPoint(ctx, point.x, point.y);
            point = [self pointOnInnerCirecleWithStage:_stage+i maxStage:MAX_STAGE];
            CGContextAddLineToPoint( ctx, point.x, point.y);
            CGContextStrokePath(ctx);
        }
        
        _stage++;
        
        if (_stage == MAX_STAGE)
            _stage = 0;
    }
    else
    {
        int currentStage = self.ratio*MAX_STAGE;
        
        CGPoint point;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(ctx, 2.0);
        
        for (int i=0 ; i<=currentStage; i++)
        {
            CGContextSetStrokeColorWithColor(ctx, [[self getColorForStage:i alpha:i!=0&&i==currentStage?1.0f:1.0f/MAX_STAGE*i] CGColor]);
            point = [self pointOnOuterCirecleWithStage:i maxStage:MAX_STAGE];
            CGContextMoveToPoint(ctx, point.x, point.y);
            point = [self pointOnInnerCirecleWithStage:i maxStage:MAX_STAGE];
            CGContextAddLineToPoint( ctx, point.x, point.y);
            CGContextStrokePath(ctx);
        }
    }
}

@end
