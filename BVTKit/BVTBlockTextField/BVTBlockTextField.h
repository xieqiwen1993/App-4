//
//  BlockTextField.h
//  Yooli
//
//  Created by Yooli on 14-8-5.
//  Copyright (c) 2014年 Yooli.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BVTBlockTextFieldHandler;

@interface BVTBlockTextField : UITextField

@property(nonatomic, assign) UIEdgeInsets contentInsets;

// 只在BVTBlockTextField 初始化时设置管用
@property(nonatomic, retain) UIColor *placeholderColor;

@property(nonatomic, retain, readonly) BVTBlockTextFieldHandler* handler;

@end


typedef BOOL (^TextFieldShouldBeginEditingBlock)(UITextField *textField);
typedef BOOL (^TextFieldShouldEndEditingBlock)(UITextField *textField);

typedef void (^TextFieldDidBeginEditingBlock)(UITextField *textField);
typedef void (^TextFieldDidEndEditingBlock)(UITextField *textField);

typedef BOOL (^TextFieldShouldChangeCharactersInRangeReplacementStringBlock)(UITextField *textField, NSRange range, NSString *string);

typedef BOOL (^TextFieldShouldClearBlock)(UITextField *textField);
typedef BOOL (^TextFieldShouldReturnBlock)(UITextField *textField);


@interface BVTBlockTextFieldHandler : NSObject <UITextFieldDelegate>

@property(nonatomic, copy) TextFieldShouldBeginEditingBlock textFieldShouldBeginEditingBlock;
@property(nonatomic, copy) TextFieldShouldEndEditingBlock textFieldShouldEndEditingBlock;
@property(nonatomic, copy) TextFieldDidBeginEditingBlock textFieldDidBeginEditingBlock;
@property(nonatomic, copy) TextFieldDidEndEditingBlock textFieldDidEndEditingBlock;
@property(nonatomic, copy) TextFieldShouldChangeCharactersInRangeReplacementStringBlock textFieldShouldChangeCharactersInRangeReplacementStringBlock;
@property(nonatomic, copy) TextFieldShouldClearBlock textFieldShouldClearBlock;
@property(nonatomic, copy) TextFieldShouldReturnBlock textFieldShouldReturnBlock;

@end



