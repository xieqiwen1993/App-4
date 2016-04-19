//
//  TestPageView.h
//  Yooli
//
//  Created by Yooli on 15-1-6.
//  Copyright (c) 2015年 Yooli.com. All rights reserved.
//

#import "BVTKit.h"


#define FixedNibCell(CLASS, VARIABLE, ...) autoreleasepool{} \
        \
        macro_if_eq(0, macro_argcount(__VA_ARGS__)) \
        (FixedNibCellNoHeight(CLASS, VARIABLE)) \
        (FixedNibCellHaveHeight(CLASS, VARIABLE, macro_retFirst(__VA_ARGS__)))

#define FixedNibCellNoHeight(CLASS, VARIABLE) \
        CLASS *VARIABLE = nil; \
        { \
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@#CLASS owner:nil options:nil]; \
            if ([nibs count] > 0) { \
                VARIABLE = [nibs objectAtIndex:0]; \
                [tableView addCellInfo:VARIABLE]; \
            } \
        }

#define FixedNibCellHaveHeight(CLASS, VARIABLE, HEIGHT) \
        CLASS *VARIABLE = nil; \
        { \
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@#CLASS owner:nil options:nil]; \
            if ([nibs count] > 0) { \
                VARIABLE = [nibs objectAtIndex:0]; \
                [tableView addCellInfo:VARIABLE]; \
            } \
        } \
        VARIABLE.height = HEIGHT;


#define FixedCell(CLASS, VARIABLE, ...) autoreleasepool{} \
        \
        macro_if_eq(0, macro_argcount(__VA_ARGS__)) \
        (FixedCellNoHeight(CLASS, VARIABLE)) \
        (FixedCellHaveHeight(CLASS, VARIABLE, macro_retFirst(__VA_ARGS__)))

#define FixedCellNoHeight(CLASS, VARIABLE) \
        \
        CLASS *VARIABLE = [[CLASS alloc] init]; \
        [tableView addCellInfo:VARIABLE];

#define FixedCellHaveHeight(CLASS, VARIABLE, HEIGHT) \
        \
        CLASS *VARIABLE = [[CLASS alloc] init]; \
        [tableView addCellInfo:VARIABLE]; \
        VARIABLE.height = HEIGHT;


#define ReuseCell(CLASS, VARIABLE, identifier) autoreleasepool{} \
        \
        [tableView registerClass:[CLASS class] forCellReuseIdentifier:identifier]; \
        BVTTableViewCellInfo *info_##VARIABLE = [[BVTTableViewCellInfo alloc] init]; \
        info_##VARIABLE.reuseIdentifier = identifier; \
        [tableView addCellInfo: info_##VARIABLE]; \
        (info_##VARIABLE).config = ^(CLASS * VARIABLE)


#define ReuseCellHeight(VARIABLE)  autoreleasepool{} \
        \
        (info_##VARIABLE).height = ^


#import <UIKit/UIKit.h>

@class BVTTableViewCell;
@class BVTTableViewCellInfo;
@class BVTTableViewDataSource;
@class BVTTableViewDelegate;

@protocol BVTTableViewLoadCellDelegate ;
@protocol BVTScrollViewDelegate ;

@interface BVTTableView : UITableView

// 只可用这个初始化
- (id)initWithFrame:(CGRect)frame;

#pragma mark - 以下方法在初始化之后调用，以下属性在初始化之后设置

// cell之间不画分隔线 默认为NO
@property (nonatomic, assign) BOOL cellSeparatorNone;

// 一般不会用到
@property (nonatomic, strong, readonly) BVTTableViewDelegate *bvtDelegate;

// 一般不会用到
@property (nonatomic, strong, readonly) BVTTableViewDataSource *bvtDataSource;

// 接收UIScrollViewDelegate方法
@property (nonatomic, weak) id<BVTScrollViewDelegate> scrollViewDelegate;

// table view 的数据源， 当table view要展示列表时，设置这一项
@property (nonatomic, strong) NSArray *dataList;

// table view 的列表中的 cell 的类型，当table view要展示列表时，设置这一项
@property (nonatomic, assign) Class listCellClass;

// 是否随键盘弹出调整frame, default NO
@property (nonatomic, assign) BOOL fixedFrame;

/** 
 * UITableView的属性 设置cell高度的缺省值
 * 对于List中的cell高度为rowHeight
 * 对于FixedCell，有3个地方可以设置一个cell的高度，按优先级排序如下:
 
 * 1. cell.height   2. [cell getHeight]     3. tableView.rowHeight;
 
 * 对于ReusedCell，有2个地方可以设置一个cell的高度，按优先级排序如下：
 
 * 1. ReuseCellHeight(VARIABLE)     2. tableView.rowHeight;

 * @property (nonatomic)          CGFloat                     rowHeight;

 */

/**
 *  UITableView的属性 设置section之间间隔距离的缺省值
 *
 *  @property (nonatomic)          CGFloat                     sectionHeaderHeight;
 */

@property (nonatomic, assign) id<BVTTableViewLoadCellDelegate> bvtLoadCellDelegate;

// 在这个方法内定义cell
- (void)loadCellData;

#pragma mark - 以上方法在初始化之后调用，以上属性在初始化之后设置

// 重新加载cell 需要重新画cell时调用
- (void)reloadCellData;

/**
 * 这个方法由marco调用，不需要手动调用
 * 添加cell 不变的cell用BVTTableViewCell的子类实例化 可变的cell用PageTableViewCellInfo实例化
 */
- (void)addCellInfo:(id)cellInfo;

// 在afterCell后面插入一个cell
- (void)insertCell:(id)cell afterCell:(id)afterCell;

// 删除一个cell
- (void)deleteCell:(id)cell;

// 添加section header 高度为 sectionHeaderHeight
- (void)addSectionHeader;

// 添加section header 并 设置高度
- (void)addSectionHeaderWithHeight:(CGFloat)height;

// 与 addSectionHeaderWithHeight 作用完全一样
- (void)addBlackSpaceWithHeight:(CGFloat)height;

// 添加一个section 这个section是由一个cell list组成， 这个list 应该是是table view的最后一个section
- (void)addListCellSection;

@end

@protocol BVTTableViewLoadCellDelegate <NSObject>

@optional

- (void)tableViewLoadCell:(BVTTableView *)tableView;

- (void)tableView:(BVTTableView *)tableView
       configCell:(BVTTableViewCell *)cell
        indexPath:(NSIndexPath *)indexPath
     withCellData:(id)data;

- (void)tableView:(BVTTableView *)tableView
    didSelectCell:(BVTTableViewCell *)cell
        indexPath:(NSIndexPath *)indexPath
     withCellData:(id)data;

@end


@protocol BVTScrollViewDelegate <NSObject>
@optional
- (void)scrollViewDidScroll:(BVTTableView *)tableView;
- (void)scrollViewDidZoom:(BVTTableView *)tableView;
- (void)scrollViewWillBeginDragging:(BVTTableView *)tableView;
- (void)scrollViewWillEndDragging:(BVTTableView *)tableView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)scrollViewDidEndDragging:(BVTTableView *)tableView willDecelerate:(BOOL)decelerate;
- (void)scrollViewWillBeginDecelerating:(BVTTableView *)tableView;
- (void)scrollViewDidEndDecelerating:(BVTTableView *)tableView;
- (void)scrollViewDidEndScrollingAnimation:(BVTTableView *)tableView;
- (UIView *)viewForZoomingInScrollView:(BVTTableView *)tableView;
- (void)scrollViewWillBeginZooming:(BVTTableView *)tableView withView:(UIView *)view;
- (void)scrollViewDidEndZooming:(BVTTableView *)tableView withView:(UIView *)view atScale:(CGFloat)scale;
- (BOOL)scrollViewShouldScrollToTop:(BVTTableView *)tableView;
- (void)scrollViewDidScrollToTop:(BVTTableView *)tableView;

@end
