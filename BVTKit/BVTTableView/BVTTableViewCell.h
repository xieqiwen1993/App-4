//
//  BVTTableViewCell.h
//  Yooli
//
//  Created by Yooli on 15-1-6.
//  Copyright (c) 2015年 Yooli.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellBgView.h"

typedef double (^HeightBlock)(void);
typedef void (^ConfigBlock)();
typedef void (^TapAction)();

@class BVTTableView;

@interface BVTTableViewCellInfo : NSObject

@property (nonatomic, copy) NSString *reuseIdentifier;

//用于配置可重用的cell
@property (nonatomic, copy) ConfigBlock config;

//用于返回高度可能变化的cell
@property (nonatomic, copy) HeightBlock height;

@end

typedef NS_ENUM(NSInteger, BVTTableViewCellSeparatorType) {
    BVTTableViewCellSeparatorNone,
    BVTTableViewCellSeparatorLine,
    BVTTableViewCellSeparatorLineIndent
};


@interface BVTTableViewCell : UITableViewCell

//对于一次创建后就不再修改的cell 高度不是默认时 设置这个height
@property (nonatomic, assign) CGFloat height;

//顶部分割线
@property (nonatomic, assign) BVTTableViewCellSeparatorType topSeparatorType;

//底部分割线
@property (nonatomic, assign) BVTTableViewCellSeparatorType bottomSeperatorType;

//设置cell之间分割线的颜色
@property (nonatomic, strong) UIColor *splitterColor;

//代替 tableView:didSelectRowAtIndexPath:
@property (nonatomic, copy) TapAction didSelect;

//默认分割
@property (nonatomic, assign) BOOL defaultSeparator;

//是否响应did select事件
@property (nonatomic, assign) BOOL enabled;


//创建不变化的cell
- (id)init;

//通过设置 registerClass:forCellReuseIdentifier: 由 dequeueReusableCellWithIdentifier: 根据需要调用 创建cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (BVTTableView *)getTableView;

//重载
- (void)prepareForReuse;

//重载
- (CGFloat)getHeight;

@end
