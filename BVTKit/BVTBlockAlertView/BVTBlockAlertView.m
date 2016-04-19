//
//  BVTBlockAlertView.m
//  Yooli
//
//  Created by Yooli on 5/29/14.
//  Copyright (c) 2014 Yooli. All rights reserved.
//

#import "BVTBlockAlertView.h"

@interface BVTBlockAlertView : UIAlertView <UIAlertViewDelegate>
{
    CancelHandler _cancelHandler;
    DismissHandler _dismissHandler;
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelHandler:(CancelHandler)cancelHandler dismissHandler:(DismissHandler)dismissHandler;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelHandler:(CancelHandler)cancelHandler dismissHandler:(DismissHandler)dismissHandler;

@end

@implementation BVTBlockAlertView

+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelHandler:(CancelHandler)cancelHandler dismissHandler:(DismissHandler)dismissHandler
{
	BVTBlockAlertView *alertView = [[BVTBlockAlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles cancelHandler:cancelHandler dismissHandler:dismissHandler];
	[alertView show];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelHandler:(CancelHandler)cancelHandler dismissHandler:(DismissHandler)dismissHandler
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    if (self)
    {
        for (NSString *otherTitle in otherButtonTitles)
        {
            [self addButtonWithTitle:otherTitle];
        }
        
        _cancelHandler = [cancelHandler copy];
        _dismissHandler = [dismissHandler copy];
        
    }
    return self;
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == self.cancelButtonIndex)
    {
        if (_cancelHandler)
            _cancelHandler();
    }
    else
    {
        if (_dismissHandler)
            _dismissHandler(buttonIndex - self.cancelButtonIndex);
    }
}

@end


@interface BVTAlertController : UIAlertController

@end

@implementation BVTAlertController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.view.center = self.view.superview.center;
}

@end

@implementation BVTAlertView

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)show
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f) {
        BVTBlockAlertView *alert = [[BVTBlockAlertView alloc] initWithTitle:self.title message:self.message cancelButtonTitle:self.cancelButtonTitle otherButtonTitles:self.otherButtonTitles cancelHandler:self.cancelHandler dismissHandler:self.dismissHandler];
        [alert show];
    }
    else {
        BVTAlertController *alert = [BVTAlertController alertControllerWithTitle:self.title message:self.message preferredStyle:UIAlertControllerStyleAlert];
        
        __weak typeof(alert) weakAlert = alert;
        [alert addAction:[UIAlertAction actionWithTitle:self.cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [weakAlert dismissViewControllerAnimated:NO completion:nil];
            
			if (self.cancelHandler) {
                self.cancelHandler();
            }
        }]];
        
        for (int i=0; i<self.otherButtonTitles.count; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:[self.otherButtonTitles objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [weakAlert dismissViewControllerAnimated:NO completion:nil];
                
				if (self.dismissHandler) {
                    self.dismissHandler(i);
                }
            }]];
        }
        
        [self.delegate presentViewController:alert animated:YES completion:nil];
    }
}

@end
