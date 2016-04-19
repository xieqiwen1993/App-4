//
//  BlockTextField.m
//  Yooli
//
//  Created by Yooli on 14-8-5.
//  Copyright (c) 2014年 Yooli.com. All rights reserved.
//

#import "BVTBlockTextField.h"

@implementation BVTBlockTextFieldHandler


#pragma mark - delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.textFieldShouldBeginEditingBlock)
        return self.textFieldShouldBeginEditingBlock(textField);
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.textFieldDidBeginEditingBlock)
        self.textFieldDidBeginEditingBlock(textField);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.textFieldShouldEndEditingBlock)
        return self.textFieldShouldEndEditingBlock(textField);
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.textFieldDidEndEditingBlock)
        self.textFieldDidEndEditingBlock(textField);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.textFieldShouldChangeCharactersInRangeReplacementStringBlock)
        return self.textFieldShouldChangeCharactersInRangeReplacementStringBlock(textField, range, string);
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.textFieldShouldClearBlock)
        return self.textFieldShouldClearBlock(textField);
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.textFieldShouldReturnBlock)
        return self.textFieldShouldReturnBlock(textField);
    return YES;
}

@end


@implementation BVTBlockTextField

- (void)_setup
{
    self.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.placeholderColor = [UIColor grayColor];
}

- (void)awakeFromNib
{
    [self _setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _handler = [[BVTBlockTextFieldHandler alloc] init];
        self.delegate = _handler;
        [self _setup];
    }
    return self;
}

#pragma mark -

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.contentInsets.left, self.contentInsets.top);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.contentInsets.left, self.contentInsets.top);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.contentInsets.left, self.contentInsets.top);
}

// Call setNeedsDisplay on the UITextField does not call the drawPlaceholderInRect method again.
- (void)drawPlaceholderInRect:(CGRect)rect
{
    if (![self respondsToSelector:@selector(setAttributedPlaceholder:)] && self.placeholderColor) {
        [self.placeholderColor setFill];
        [[self placeholder] drawInRect:rect withFont:self.font];
    } else {
        [super drawPlaceholderInRect:rect];
    }
}

#pragma mark -

- (void)setPlaceholder:(NSString *)placeholder
{
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:self.placeholderColor}];
    } else {
        [super setPlaceholder:placeholder];
    }
}

@end
