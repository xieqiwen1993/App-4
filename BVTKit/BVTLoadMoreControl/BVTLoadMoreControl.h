//
//  LoadMoreControl.h
//  App
//
//  Created by Yooli on 14-8-24.
//  Copyright (c) 2014年 yooli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BVTLoadMoreControl : UIControl

@property(nonatomic, readonly, getter=isLoading) BOOL loading;

- (void)endLoading;
- (void)endLoadingWithHasMore:(BOOL)hasMore;

@end
