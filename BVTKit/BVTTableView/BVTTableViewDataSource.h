//
//  PageTableViewDataSource.h
//  Pods
//
//  Created by Yooli on 15/4/26.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BVTTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong, readonly) NSMutableArray *sections;
@property (nonatomic, strong, readonly) NSMutableDictionary *sectionHeaders;
@property (nonatomic, assign, readonly) NSInteger listCellSectionNum;

- (void)addSectionHeader;
- (void)addSectionHeaderWithHeight:(CGFloat)height;
- (void)addCellInfo:(id)cellInfo;
- (void)addListCellSection;
- (void)clearCellData;
- (NSIndexPath *)insertCell:(id)cell afterCell:(id)afterCell;
- (NSIndexPath *)deleteCell:(id)cell;

@end
