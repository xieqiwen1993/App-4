//
//  SalerMessageViewController.h
//  App
//
//  Created by Gaiminghui on 16/4/14.
//  Copyright © 2016年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalerMessageViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIImageView *currentImageView;   // 当前imageView
@property (nonatomic,weak) UIImageView *nextImageView;      // 下一个imageView
@property (nonatomic,weak) UIImageView *preImageView;       //上一个imageView
@property (nonatomic,assign) BOOL isDragging;               //是否正在拖动
@property (nonatomic,strong)NSTimer *timer;                 //设置动画

@property (weak, nonatomic)UIPageControl *pageView;



@end
