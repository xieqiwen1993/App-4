//
//  BVTLoadingView.m
//  ContactInformation
//
//  Created by Yooli on 11-8-10.
//  Copyright 2011年 Yooli. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BVTLoadingView.h"
#import "BVTIndicatorView.h"

#define MIN_WIDTH   200
#define MIN_HEIGHT  100

#define MARGIN_HORIZONTAL   10
#define MARGIN_VERTICAL     10
#define PADDING_HORIZONTAL  10
#define PADDING_VERTICAL    10

@interface BVTLoadingView ()
{
    UIView      *_viewBackground;
    BVTIndicatorView *_indicatorView;
    UILabel     *_label;
    UIButton    *_button;
}

@property (nonatomic) NSUInteger identifier;
@property (nonatomic, weak) id <BVTLoadingViewDelegate> delegate;

@end

@implementation BVTLoadingView


- (id)initWithFrame:(CGRect)frame
{
//    CGRect frame = ((AppDelegate *)[UIApplication sharedApplication].delegate).window.frame;
    
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.identifier = 0;
        
        CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
        
        _viewBackground = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width-MIN_WIDTH)/2, (frame.size.height-statusBarFrame.size.height)/3-MIN_HEIGHT/2, MIN_WIDTH, MIN_HEIGHT)];
        [_viewBackground setBackgroundColor:[UIColor blackColor]];
        [_viewBackground setAlpha:0.8];
        _viewBackground.layer.cornerRadius = 6.0f;
        [self addSubview:_viewBackground];
        
        _indicatorView = [[BVTIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
		[_indicatorView setCenter:CGPointMake(_viewBackground.frame.size.width/2, PADDING_VERTICAL+20)];
        [_indicatorView startAnimating];
        [_indicatorView setColor:[UIColor whiteColor]];
        [_viewBackground addSubview:_indicatorView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(PADDING_HORIZONTAL, _viewBackground.frame.origin.y+_viewBackground.frame.size.height+PADDING_VERTICAL, _viewBackground.frame.size.width-2*PADDING_HORIZONTAL, _viewBackground.frame.size.height-2*PADDING_VERTICAL-_viewBackground.frame.size.height-PADDING_VERTICAL)];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setBackgroundColor:[UIColor clearColor]];
        [_label setNumberOfLines:0];
        [_label setTextColor:[UIColor whiteColor]];
        [_viewBackground addSubview:_label];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setFrame:CGRectMake(_viewBackground.frame.origin.x+_viewBackground.frame.size.width-21-5, _viewBackground.frame.origin.y+5, 21, 22)];
        [_button addTarget:self action:@selector(onBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_button setHidden:YES];
        [self addSubview:_button];
    }
    return self;
}

- (void)dealloc
{
#ifdef ENABLE_DEALLOC_LOG
    NSLog(@"dealloc %@", [self.class description]);
#endif
    self.delegate = nil;
}

#pragma mark - Public functional

- (void)setCancelImage:(UIImage *)cancelImage {
    [_button setImage:cancelImage forState:UIControlStateNormal];
}


- (void)show:(NSString *)title cancelDelegate:(__weak id<BVTLoadingViewDelegate>)cancelDelegate tag:(NSUInteger)tag
{
    self.identifier = tag;
    self.delegate = cancelDelegate;
    
    [_label setText:title];
    [_button setHidden:cancelDelegate==nil];
    
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    CGSize size = [_label.text sizeWithFont:_label.font constrainedToSize:CGSizeMake(self.frame.size.width-2*MARGIN_HORIZONTAL-2*PADDING_HORIZONTAL, self.frame.size.height-statusBarFrame.size.height-2*MARGIN_VERTICAL-2*PADDING_VERTICAL-_indicatorView.frame.size.height-PADDING_VERTICAL) lineBreakMode:_label.lineBreakMode];
    
    CGFloat width  = MIN(MAX(MIN_WIDTH, size.width+2*PADDING_HORIZONTAL), self.frame.size.width-2*MARGIN_HORIZONTAL);
    CGFloat height = MIN(MAX(MIN_HEIGHT, PADDING_VERTICAL+_indicatorView.frame.size.height+PADDING_VERTICAL+size.height+PADDING_VERTICAL), self.frame.size.height-statusBarFrame.size.height-2*MARGIN_VERTICAL);
    CGFloat x = (self.frame.size.width-width)/2;
    CGFloat y = (self.frame.size.height-statusBarFrame.size.height)/3-height/2;
    if (y < MARGIN_VERTICAL)
        y = MARGIN_VERTICAL;
    y += statusBarFrame.size.height;
    
    [_viewBackground setFrame:CGRectMake(x, y, width, height)];
    [_label setFrame:CGRectMake(PADDING_HORIZONTAL, _indicatorView.frame.origin.y+_indicatorView.frame.size.height+PADDING_VERTICAL, _viewBackground.frame.size.width-2*PADDING_HORIZONTAL, size.height)];
    [_button setFrame:CGRectMake(_viewBackground.frame.origin.x+_viewBackground.frame.size.width-_button.frame.size.width-5, _viewBackground.frame.origin.y+5, _button.frame.size.width, _button.frame.size.height)];
    
    [self setHidden:NO];

    [_indicatorView startAnimating];
}

- (void)hide
{
    self.delegate = nil;
    
    [_label setText:nil];
    
    [_button setHidden:YES];
    
    [self setHidden:YES];
    [_indicatorView stopAnimating];
}

#pragma mark - Button event

- (IBAction)onBtnCancel:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onLoadingCancelled:)])
        [self.delegate onLoadingCancelled:self.identifier];
    
    [self hide];
}

@end
