//
//  LoadMoreControl.m
//  App
//
//  Created by Yooli on 14-8-24.
//  Copyright (c) 2014年 yooli. All rights reserved.
//

#import "BVTLoadMoreControl.h"

#define kLoadMoreControlHeight  44
#define kDragOffset             30

typedef NS_ENUM(NSInteger, LoadMoreControlState) {
    LoadMoreControlStateNormal,
    LoadMoreControlStatePulling,
    LoadMoreControlStateLoading
};

@interface BVTLoadMoreControl ()

@property(nonatomic, weak) UIScrollView *scrollView;
@property(nonatomic, assign) LoadMoreControlState loadMoreControlState;
@property(nonatomic, strong) UILabel *indicatorLabel;
@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property(nonatomic, assign) BOOL hasMore;

@end

@implementation BVTLoadMoreControl

- (void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [_scrollView removeObserver:self forKeyPath:@"contentSize"];
    _scrollView = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _indicatorLabel = [[UILabel alloc] init];
        _indicatorLabel.backgroundColor = [UIColor clearColor];
        _indicatorLabel.textAlignment = NSTextAlignmentCenter;
        _indicatorLabel.font = [UIFont systemFontOfSize:14];
        _indicatorLabel.textColor = [UIColor grayColor];
        _indicatorLabel.text = @"上拉加载更多";
        [self addSubview:_indicatorLabel];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
        [self addSubview:_indicatorView];
        
        _loadMoreControlState = LoadMoreControlStateNormal;
        _hasMore = YES;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
	
	if (newSuperview) {
		if ([newSuperview isKindOfClass:[UIScrollView class]]) {
			self.scrollView = (UIScrollView *)newSuperview;
			self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.frame.size.width, kLoadMoreControlHeight);
			self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, kLoadMoreControlHeight, 0);
			[self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
			[self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
			self.indicatorLabel.frame = self.bounds;
			self.indicatorView.center = CGPointMake(self.frame.size.width/3, self.frame.size.height/2);
		}
	} else {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
        [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
        self.scrollView = nil;
    }
}

- (BOOL)isLoading
{
    return self.loadMoreControlState == LoadMoreControlStateLoading;
}

- (BOOL)isBouncing
{
    if (self.scrollView.contentSize.height+kLoadMoreControlHeight < self.scrollView.frame.size.height)
        return self.scrollView.contentOffset.y > kDragOffset;
    return self.scrollView.contentOffset.y > self.scrollView.contentSize.height-self.scrollView.frame.size.height+kLoadMoreControlHeight+kDragOffset;
}

- (BOOL)isDragging
{
    return [self.scrollView isDragging];
}

- (BOOL)isPulling
{
    return self.loadMoreControlState == LoadMoreControlStatePulling;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if ([self hasMore]) {
            if (![self isBouncing] && [self isPulling] && ![self isDragging]) {
                [self beginLoading];
            } else if (![self isLoading] && [self isBouncing] && ![self isPulling] && [self isDragging]) {
                [self beginPulling];
            } else if (![self isBouncing] && [self isPulling] && [self isDragging]) {
                [self endPulling];
            }
        }
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.frame.size.width, kLoadMoreControlHeight);
    }
}

- (void)beginLoading
{
    self.indicatorLabel.text = @"正在加载";
    [self.indicatorView startAnimating];
    self.loadMoreControlState = LoadMoreControlStateLoading;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)endLoading
{
	[self endLoadingWithHasMore:YES];
}

- (void)endLoadingWithHasMore:(BOOL)hasMore
{
    if (hasMore)
        self.indicatorLabel.text = @"上拉加载更多";
    else
        self.indicatorLabel.text = @"没有更多";
    
    [self.indicatorView stopAnimating];
    self.loadMoreControlState = LoadMoreControlStateNormal;
    
    _hasMore = hasMore;
}

- (void)beginPulling
{
    self.indicatorLabel.text = @"松开加载";
    [self.indicatorView stopAnimating];
    self.loadMoreControlState = LoadMoreControlStatePulling;
}

- (void)endPulling
{
    self.indicatorLabel.text = @"上拉加载更多";
    [self.indicatorView stopAnimating];
    self.loadMoreControlState = LoadMoreControlStateNormal;
}

@end
