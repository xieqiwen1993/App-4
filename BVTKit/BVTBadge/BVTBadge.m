//
//  BVTBadge.m
//  App
//
//  Created by Yooli on 15-5-11.
//  Copyright (c) 2015年 yooli. All rights reserved.
//

#import "BVTBadge.h"

#define BADGE_DIAMETER 9.0

@implementation BVTBadge

+ (instancetype)badge
{
	return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, BADGE_DIAMETER, BADGE_DIAMETER)];
	if (self) {
		self.backgroundColor = [UIColor redColor];
        _diameter = BADGE_DIAMETER;
	}
	return self;
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:CGRectMake(frame.origin.x, frame.origin.y, _diameter, _diameter)];
    self.layer.cornerRadius = _diameter / 2;
}

- (void)setOrigin:(CGPoint)origin
{
	self.frame = CGRectMake(origin.x, origin.y, _diameter, _diameter);
}

@end
