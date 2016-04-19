//
//  BVTTableViewCell.m
//  Yooli
//
//  Created by Yooli on 15-1-6.
//  Copyright (c) 2015年 Yooli.com. All rights reserved.
//

#import "BVTTableViewCell.h"
#import "BVTTableView.h"

#pragma mark - BVTTableViewCellInfo

@implementation BVTTableViewCellInfo

@end

#pragma mark - BVTTableViewCell

@implementation BVTTableViewCell

- (id)init
{
    return [self initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CellBgView *bgView = [[CellBgView alloc] initWithFrame:CGRectZero];
        bgView.splitterAlignment = SplitterAlignmentRight;
        self.backgroundView = bgView;
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.splitterColor = [UIColor colorWithRed:224.0f/255.0f green:228.0f/255.0f blue:229.0f/255.0f alpha:1];
        
        self.defaultSeparator = YES;
        self.clipsToBounds = YES;
        self.enabled = YES;
    }
    return self;
}

- (void)awakeFromNib {
    
    CellBgView *bgView = [[CellBgView alloc] initWithFrame:CGRectZero];
    bgView.splitterAlignment = SplitterAlignmentRight;
    self.backgroundView = bgView;
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.splitterColor = [UIColor colorWithRed:224.0f/255.0f green:228.0f/255.0f blue:229.0f/255.0f alpha:1];
    
    self.defaultSeparator = YES;
    self.clipsToBounds = YES;
    self.enabled = YES;
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
}

//- (void)setBackgroundColor:(UIColor *)backgroundColor {
//    super.backgroundColor = backgroundColor;
//    self.backgroundView.backgroundColor = backgroundColor;
//}

- (void)setSplitterColor:(UIColor *)splitterColor {
    _splitterColor = splitterColor;
    CellBgView *cellBgView = (CellBgView *)self.backgroundView;
    cellBgView.splitterColor = splitterColor;
}

#pragma mark - Public Interface

- (void)setTopSeparatorType:(BVTTableViewCellSeparatorType)topSeparatorType {

    _topSeparatorType = topSeparatorType;
    CellBgView *cellBgView = (CellBgView *)self.backgroundView;
    cellBgView.splitterOnTop = YES;
    switch (topSeparatorType) {
        case BVTTableViewCellSeparatorNone:
            cellBgView.splitterOnTop = NO;
            break;
        case BVTTableViewCellSeparatorLine:
            cellBgView.splitterOnTop = YES;
            cellBgView.splitterIndentationTop = 0.0f;
            break;
        case BVTTableViewCellSeparatorLineIndent:
            cellBgView.splitterOnTop = YES;
            cellBgView.splitterIndentationTop = 15.0f;
        default:
            break;
    }
    self.defaultSeparator = NO;
}

- (void)setBottomSeperatorType:(BVTTableViewCellSeparatorType)bottomSeperatorType {
    
    _bottomSeperatorType = bottomSeperatorType;
    CellBgView *cellBgView = (CellBgView *)self.backgroundView;
    cellBgView.splitterOnBottom = YES;
    switch (bottomSeperatorType) {
        case BVTTableViewCellSeparatorNone:
            cellBgView.splitterOnBottom = NO;
            break;
        case BVTTableViewCellSeparatorLine:
            cellBgView.splitterOnBottom = YES;
            cellBgView.splitterIndentationBottom = 0.0f;
            break;
        case BVTTableViewCellSeparatorLineIndent:
            cellBgView.splitterOnBottom = YES;
            cellBgView.splitterIndentationBottom = 15.0f;
        default:
            break;
    }
    self.defaultSeparator = NO;
}

- (BVTTableView *)getTableView
{
    for (UIView *view = self.superview ; view != nil; view = view.superview)
    {
        if ([view isKindOfClass:[BVTTableView class]])
        {
            return (BVTTableView *)view;
        }
    }
    return nil;
}

- (CGFloat)getHeight {
    
    return 0.0f;
}


@end




