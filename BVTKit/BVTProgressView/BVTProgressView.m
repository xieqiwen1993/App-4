//
//  BVTProgressView.m
//  Yooli
//
//  Created by Yooli on 7/9/14.
//  Copyright (c) 2014 Yooli.com. All rights reserved.
//

#import "BVTProgressView.h"

@interface BVTProgressView ()

@property (nonatomic, strong) UIView *trackView;
@property (nonatomic, strong) UIView *progressView;

@end

@implementation BVTProgressView

@dynamic trackColor;
@dynamic progressColor;

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _trackView = [[UIView alloc] init];
        _trackView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_trackView];
        
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = [UIColor greenColor];
        [self addSubview:_progressView];
        
        _progress = 0.0;
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGFloat w = self.bounds.size.width;
	CGFloat h = self.bounds.size.height;
	
	self.trackView.frame = CGRectMake(0, 0, w, h);
	self.progressView.frame = CGRectMake(0, 0, MAX(0, w*self.progress), h);
	self.trackView.layer.cornerRadius = h/2;
	self.progressView.layer.cornerRadius = h/2;
}

#pragma mark - Public Interface

- (void)setProgress:(double)progress
{
	CGFloat w = self.bounds.size.width;
	CGFloat h = self.bounds.size.height;
    _progress = MIN(1, MAX(0, progress));
    self.progressView.frame = CGRectMake(0, 0, MAX(0, w*_progress), h);
}

- (void)setTrackColor:(UIColor *)trackColor
{
    self.trackView.backgroundColor = trackColor;
}

- (UIColor *)trackColor
{
    return self.trackView.backgroundColor;
}

- (void)setProgressColor:(UIColor *)progressColor
{
    self.progressView.backgroundColor = progressColor;
}

- (UIColor *)progressColor
{
    return self.progressView.backgroundColor;
}

@end
