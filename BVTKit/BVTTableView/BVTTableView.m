//
//  BVTTableView.m
//  Yooli
//
//  Created by Yooli on 15-1-6.
//  Copyright (c) 2015年 Yooli.com. All rights reserved.
//

#import "BVTTableView.h"
#import "BVTTableViewCell.h"
#import <objc/runtime.h>
#import "BVTTableViewDelegate.h"
#import "BVTTableViewDataSource.h"

@interface BVTTableView ()

@property (nonatomic, assign) CGRect tFrameVar;
@property (nonatomic, assign) BOOL isShowingKeyboard;

@property (nonatomic, strong) BVTTableViewDelegate *bvtDelegate;

@property (nonatomic, strong) BVTTableViewDataSource *bvtDataSource;

@end

@implementation BVTTableView

@dynamic listCellClass;

- (id)initWithFrame:(CGRect)frame {
    
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {

        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        _bvtDelegate = [[BVTTableViewDelegate alloc] init];
        self.delegate = _bvtDelegate;
        
        _bvtDataSource = [[BVTTableViewDataSource alloc] init];
        self.dataSource = _bvtDataSource;
        
        self.cellSeparatorNone = NO;
        
        self.fixedFrame = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [tap setCancelsTouchesInView:NO];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Tap Action

- (void)tapAction:(UITapGestureRecognizer *)recognizer {
    [self endEditing:YES];
}

#pragma mark - Public Interface

- (void)setFixedFrame:(BOOL)fixedFrame
{
    if (_fixedFrame == fixedFrame) {
        return ;
    }
    
    _fixedFrame = fixedFrame;
    if (fixedFrame) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)loadCellData {
    
    if (self.bvtLoadCellDelegate != nil
        && [self.bvtLoadCellDelegate respondsToSelector:@selector(tableViewLoadCell:)]) {
        
        [self.bvtLoadCellDelegate performSelector:@selector(tableViewLoadCell:) withObject:self];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [self.ptvLoadCellDelegate pagetableViewLoadCell:self];
//        });
    }
}

- (void)reloadCellData {
    
    if (self.bvtLoadCellDelegate != nil) {
        
        [self.bvtDataSource clearCellData];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [self.ptvLoadCellDelegate pagetableViewLoadCell:self];
//        });
        if ([self.bvtLoadCellDelegate respondsToSelector:@selector(tableViewLoadCell:)]) {
            
            [self.bvtLoadCellDelegate performSelector:@selector(tableViewLoadCell:) withObject:self];
        }
        
        [self reloadData];
    }
}

- (void)addCellInfo:(id)cellInfo {
    
    [self.bvtDataSource addCellInfo:cellInfo];
}

- (void)insertCell:(id)cell afterCell:(id)afterCell {
    
    NSIndexPath *indexPath = [self.bvtDataSource insertCell:cell afterCell:afterCell];
    if (indexPath) {
        [self beginUpdates];
        [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self endUpdates];
    }
}


- (void)deleteCell:(id)cell {
    
    NSIndexPath *indexPath = [self.bvtDataSource deleteCell:cell];
    if (indexPath) {
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self endUpdates];
    }
}

- (void)addSectionHeader {
    
    [self.bvtDataSource addSectionHeader];
}

- (void)addSectionHeaderWithHeight:(CGFloat)height {
    
    [self.bvtDataSource addSectionHeaderWithHeight:height];
}

- (void)addBlackSpaceWithHeight:(CGFloat)height {
    [self.bvtDataSource addSectionHeaderWithHeight:height];
}

- (void)addListCellSection {
    
    [self.bvtDataSource addListCellSection];
}

- (void)setListCellClass:(Class)listCellClass
{
    static NSString *cellIdentifier = @"cellIdentifier";
    [self registerClass:listCellClass forCellReuseIdentifier:cellIdentifier];
}

#pragma mark - Notification

- (void)onKeyboardWillShow:(NSNotification *)notification
{
    self.isShowingKeyboard = YES;
    
    NSArray *cells = [self visibleCells];
    UITableViewCell *firstResponderCell = nil;
    for (UITableViewCell *cell in cells) {
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UITextField class]] && [(UITextField *)view isFirstResponder]) {
                firstResponderCell = cell;
                break;
            }
        }
    }
    
    if (firstResponderCell == nil)
        return ;
    
    __weak typeof(self) weakSelf = self;
    
    NSNumber *duration = [notification.userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey];
    NSValue *valueRectEnd = [notification.userInfo objectForKey: UIKeyboardFrameEndUserInfoKey];
    CGRect  keyboardRect = [valueRectEnd CGRectValue];
    CGRect  selfRect = [self.superview convertRect:self.frame toView:nil];
    
    if (CGRectEqualToRect(self.tFrameVar, CGRectZero))
        self.tFrameVar = self.frame;
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        [UIView animateWithDuration:[duration floatValue] animations:^{
            weakSelf.frame = CGRectMake(weakSelf.tFrameVar.origin.x, weakSelf.tFrameVar.origin.y, weakSelf.tFrameVar.size.width, keyboardRect.origin.y-selfRect.origin.y);
            
        } completion:^(BOOL finished) {
            
            if (firstResponderCell) {
                NSIndexPath *indexPath = [weakSelf indexPathForCell:firstResponderCell];
                [weakSelf scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            }
        }];
    });
}

- (void)onKeyboardWillHide:(NSNotification *)notification
{
    self.isShowingKeyboard = NO;
    
    if (CGRectEqualToRect(self.tFrameVar, CGRectZero))
        return ;
    
    NSNumber *duration = [notification.userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:[duration floatValue] animations:^{
            weakSelf.frame = weakSelf.tFrameVar;
        } completion:^(BOOL finished) {
            if (finished && !weakSelf.isShowingKeyboard)
                weakSelf.tFrameVar = CGRectZero;
        }];
    });
}

@end
