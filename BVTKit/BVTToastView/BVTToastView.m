//
//  BVTToastView.m
//  Dragon
//
//  Created by Yooli on 12/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BVTToastView.h"

#define PADDING 5

#define DEFAULT_WIDTH   200
#define MIN_HEIGHT      150

@implementation BVTToastView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

+ (void)show:(NSString *)text dismissOption:(NSInteger)dismissOption background:(UIImage *)image
{
	UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    BVTToastView *toastView = [[BVTToastView alloc] initWithFrame:window.bounds];
    [toastView setAlpha:0];
    if ((dismissOption&BVTToastViewDismissOptionManual) != 0)
        [toastView addTarget:toastView action:@selector(onBtnToastView:) forControlEvents:UIControlEventTouchUpInside];
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(DEFAULT_WIDTH-2*PADDING, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((window.frame.size.width-size.width)/2, (window.frame.size.height-size.height)/2, size.width, size.height)];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button.titleLabel setLineBreakMode:NSLineBreakByCharWrapping];
    [button.titleLabel setNumberOfLines:0];
    if ((dismissOption&BVTToastViewDismissOptionManual) != 0)
        [button addTarget:toastView action:@selector(onBtnTextView:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat frameY = toastView.frame.size.height/3-button.frame.size.height/2;
    [button setFrame:CGRectMake((toastView.frame.size.width-button.frame.size.width)/2, frameY>0?frameY:0, button.frame.size.width, button.frame.size.height)];
    
    if (image != nil)
    {
        CGFloat y = toastView.frame.size.height/3-MAX(MIN_HEIGHT, button.frame.size.height)/2;
        UIImageView *imageViewBackground = [[UIImageView alloc] initWithFrame:CGRectMake((toastView.frame.size.width-DEFAULT_WIDTH)/2, y>0?y:0, DEFAULT_WIDTH, MAX(MIN_HEIGHT, button.frame.size.height))];
        [imageViewBackground setImage:image];
        [toastView addSubview:imageViewBackground];
    }
    else
    {
        CGFloat width  = button.frame.size.width+20;
        CGFloat height = button.frame.size.height+20;
//        UIView *viewBackground = [[UIView alloc] initWithFrame:CGRectMake((commHintView.frame.size.width-DEFAULT_WIDTH)/2, (commHintView.frame.size.height-MAX(MIN_HEIGHT, label.frame.size.height))/2, DEFAULT_WIDTH, MAX(MIN_HEIGHT, label.frame.size.height))];
        
        CGFloat y = toastView.frame.size.height/3-height/2;
        UIView *viewBackground = [[UIView alloc] initWithFrame:CGRectMake((toastView.frame.size.width-width)/2, y>0?y:0, width, height)];
        [viewBackground setBackgroundColor:[UIColor blackColor]];
        [viewBackground setAlpha:0.5];
        viewBackground.layer.cornerRadius = 2.0f;
        [toastView addSubview:viewBackground];
    }
    
    [toastView addSubview:button];
    [window addSubview:toastView];
    
    [UIView animateWithDuration:0.5f animations:^{
        [toastView setAlpha:1];
    } completion:^(BOOL finished) {
        if ((dismissOption&BVTToastViewDismissOptionAuto) != 0)
            [toastView performSelector:@selector(disappear) withObject:nil afterDelay:1.5f];
    }];
}

+ (void)show:(NSString *)text dismissOption:(NSInteger)dismissOption
{
    [self show:text dismissOption:dismissOption background:nil];
}

+ (void)show:(NSString *)text
{
    [self show:text dismissOption:BVTToastViewDismissOptionAuto|BVTToastViewDismissOptionManual background:nil];
}

- (void)disappear
{
    [UIView animateWithDuration:0.5f animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc
{
#ifdef ENABLE_DEALLOC_LOG
    NSLog(@"dealloc %@", [self.class description]);
#endif
}

- (IBAction)onBtnToastView:(id)sender
{
    BVTToastView *button = (BVTToastView *)sender;
    if ([button isKindOfClass:[BVTToastView class]])
        [button removeFromSuperview];
}

- (IBAction)onBtnTextView:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if ([button isKindOfClass:[UIButton class]])
        [button.superview removeFromSuperview];
}

@end
