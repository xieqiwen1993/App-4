//
//  BVTBlockAlertView.h
//  Yooli
//
//  Created by Yooli on 5/29/14.
//  Copyright (c) 2014 Yooli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelHandler)();
typedef void(^DismissHandler)(NSUInteger buttonIndex);

@interface BVTAlertView : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSArray *otherButtonTitles;
@property (nonatomic, weak) UIViewController *delegate;
@property (nonatomic, copy) CancelHandler cancelHandler;
@property (nonatomic, copy) DismissHandler dismissHandler;

- (void)show;

@end