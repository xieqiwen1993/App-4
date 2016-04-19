//
//  PageTableViewDataSource.m
//  Pods
//
//  Created by Yooli on 15/4/26.
//
//

#import "BVTTableViewDataSource.h"
#import "BVTTableViewCell.h"
#import "BVTTableView.h"

@interface BVTTableViewDataSource ()

@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) NSMutableDictionary *sectionHeaders;
@property (nonatomic, assign) NSInteger listCellSectionNum;

@end

@implementation BVTTableViewDataSource

- (id)init {
    
    self = [super init];
    if (self) {
        
        _listCellSectionNum = -1;
        _sections = [[NSMutableArray alloc] init];
        _sectionHeaders = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark - Public 

- (void)addCellInfo:(id)cellInfo {
    
    NSMutableArray *rows = [_sections lastObject];
    if (rows == nil) {
        
        rows = [[NSMutableArray alloc] init];
        [_sections addObject:rows];
    }
    
    [rows addObject:cellInfo];
}

- (NSIndexPath *)insertCell:(id)cell afterCell:(id)afterCell {
    
    int section = 0;
    int row = 0;
    
    for (int i=0; i<[_sections count]; i++) {
        NSMutableArray *rows = [_sections objectAtIndex:i];
        
        for (int j=0; j<[rows count]; j++) {
            id tmpCell = [rows objectAtIndex:j];
            if (cell == tmpCell)
                return nil;
        }
    }
    
    for (int i=0; i<[_sections count]; i++) {
        NSMutableArray *rows = [_sections objectAtIndex:i];

        for (int j=0; j<[rows count]; j++) {
            id tmpCell = [rows objectAtIndex:j];
            if (tmpCell == afterCell) {
                section = i;
                row = j+1;
                [rows insertObject:cell atIndex:j+1];
                return [NSIndexPath indexPathForRow:row inSection:section];
            }
        }
    }
    return nil;
}

- (NSIndexPath *)deleteCell:(id)cell {
    
    int section = 0;
    int row = 0;
    
    for (int i=0; i<[_sections count]; i++) {
        NSMutableArray *rows = [_sections objectAtIndex:i];
        
        for (int j=0; j<[rows count]; j++) {
            id tmpCell = [rows objectAtIndex:j];
            if (tmpCell == cell) {
                section = i;
                row = j;
                [rows removeObjectAtIndex:j];
                return [NSIndexPath indexPathForRow:row inSection:section];
            }
        }
    }
    
    return nil;
}

- (void)addSectionHeader {
    
    [_sectionHeaders setObject:@1 forKey:@([_sections count])];
    
    NSMutableArray *rows = [[NSMutableArray alloc] init];
    [_sections addObject:rows];
}

- (void)addSectionHeaderWithHeight:(CGFloat)height {
    
    [_sectionHeaders setObject:@(height) forKey:@([_sections count])];
    
    NSMutableArray *rows = [[NSMutableArray alloc] init];
    [_sections addObject:rows];
}

- (void)addListCellSection {
    
//    NSArray *rows = [_sections lastObject];
//    if (rows == nil || [rows count] > 0) {
//        
//        rows = [[NSMutableArray alloc] init];
//        [_sections addObject:rows];
//    }
    [self addSectionHeaderWithHeight:0.0f];
    _listCellSectionNum = [_sections count] - 1;
    [self addSectionHeaderWithHeight:0.0f];
}

- (void)clearCellData
{
    [_sections removeAllObjects];
    [_sectionHeaders removeAllObjects];
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(BVTTableView *)tableView {
    
    return [_sections count];
}

- (NSInteger)tableView:(BVTTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == _listCellSectionNum)
        return [tableView.dataList count];
    else
        return [(NSArray *)[_sections objectAtIndex:section] count];
    
    return 0;
}

- (UITableViewCell *)tableView:(BVTTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *rows = nil;
    id info = nil;
    BVTTableViewCell *cell = nil;
    
    if (indexPath.section != _listCellSectionNum) {
     
        rows = [_sections objectAtIndex:indexPath.section];
        
        if (indexPath.row < [rows count])
            info = [rows objectAtIndex:indexPath.row];
        
        
        if ([info isKindOfClass:[BVTTableViewCell class]]) {
            
            cell = (BVTTableViewCell *)info;
            
        } else if ([info isKindOfClass:[BVTTableViewCellInfo class]]) {
            
            BVTTableViewCellInfo *cellInfo = (BVTTableViewCellInfo *)info;
            
            NSString *identifier = cellInfo.reuseIdentifier;
            ConfigBlock config = cellInfo.config;
            
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (config)
                config(cell);
            
        }
        
    } else {
        
        rows = tableView.dataList;
        
        static NSString *cellIdentifier = @"cellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        id data = nil;
        
        if (indexPath.row < [tableView.dataList count])
            data = [tableView.dataList objectAtIndex:indexPath.row];
        
        if (tableView.bvtLoadCellDelegate) {
            
            if ([tableView.bvtLoadCellDelegate respondsToSelector:@selector(tableView:configCell:indexPath:withCellData:)]) {
                
                [tableView.bvtLoadCellDelegate tableView:tableView configCell:cell indexPath:indexPath withCellData:data];
                cell.defaultSeparator = YES;
                
            }
        }
    }
    
    if (tableView.cellSeparatorNone) {
        cell.topSeparatorType = BVTTableViewCellSeparatorNone;
        cell.bottomSeperatorType = BVTTableViewCellSeparatorNone;
    } else {
        if (cell.defaultSeparator) {
            
            if (indexPath.row == 0) {
                
                if ([rows count] > 1) {
                    
                    cell.topSeparatorType = BVTTableViewCellSeparatorLine;
                    cell.bottomSeperatorType = BVTTableViewCellSeparatorLineIndent;
                    
                } else {
                    
                    cell.topSeparatorType = BVTTableViewCellSeparatorLine;
                    cell.bottomSeperatorType = BVTTableViewCellSeparatorLine;
                }
                
            } else if (indexPath.row == [rows count] - 1) {
                
                cell.topSeparatorType = BVTTableViewCellSeparatorNone;
                cell.bottomSeperatorType = BVTTableViewCellSeparatorLine;
                
            } else {
                
                cell.topSeparatorType = BVTTableViewCellSeparatorNone;
                cell.bottomSeperatorType = BVTTableViewCellSeparatorLineIndent;
            }
        }
    }
    return cell;
}


@end
