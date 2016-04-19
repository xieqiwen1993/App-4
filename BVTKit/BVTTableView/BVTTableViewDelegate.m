//
//  PageTableViewDelegate.m
//  Pods
//
//  Created by Yooli on 15/4/26.
//
//

#import "BVTTableViewDelegate.h"
#import "BVTTableViewCell.h"
#import "BVTTableView.h"
#import "BVTTableViewDataSource.h"

@implementation BVTTableViewDelegate

- (id)init {
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}


#pragma mark - UITableView Delegate

- (void)tableView:(BVTTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BVTTableViewCell *cell = (BVTTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section != tableView.bvtDataSource.listCellSectionNum) {
        if (cell.didSelect && cell.enabled)
            cell.didSelect();
    } else {
        
        id data = nil;
        
        if (indexPath.row < [tableView.dataList count])
            data = [tableView.dataList objectAtIndex:indexPath.row];
        
        BVTTableViewCell *cell = (BVTTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if (tableView.bvtLoadCellDelegate)
        {
            if([tableView.bvtLoadCellDelegate respondsToSelector:@selector(tableView:didSelectCell:indexPath:withCellData:)])
            {
                [tableView.bvtLoadCellDelegate tableView:tableView didSelectCell:cell indexPath:indexPath withCellData:data];
            }
        }
    }
}


- (UIView *)tableView:(BVTTableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(BVTTableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(BVTTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    NSNumber *haveHeader = [tableView.bvtDataSource.sectionHeaders objectForKey:@(section)];
    
    if ([haveHeader intValue] == 1)
        return tableView.sectionHeaderHeight;
    else {
        
        CGFloat height = [haveHeader floatValue];
        return height;
    }
}


- (CGFloat)tableView:(BVTTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray *rows = nil;
    id info = nil;
    
    if (indexPath.section != tableView.bvtDataSource.listCellSectionNum) {
     
        rows = [tableView.bvtDataSource.sections objectAtIndex:indexPath.section];
        
        if (indexPath.row < [rows count])
            info = [rows objectAtIndex:indexPath.row];
        
        if ([info isKindOfClass:[BVTTableViewCell class]]) {
            
            BVTTableViewCell *cell = (BVTTableViewCell *)info;
            
            if (cell.height > 0)
                return cell.height;
            else if ([cell getHeight] > 0)
                return [cell getHeight];
            else
                return tableView.rowHeight;
            
        } else if ([info isKindOfClass:[BVTTableViewCellInfo class]]) {
            
            BVTTableViewCellInfo *cellInfo = (BVTTableViewCellInfo *)info;
            if (cellInfo.height)
                return cellInfo.height();
            
            return tableView.rowHeight;
        }
        
    } else {
        
        return tableView.rowHeight;
    }
    
    return 0;
}

#pragma mark - BVTScrollView Delegate 

- (void)scrollViewDidScroll:(BVTTableView *)tableView {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [tableView.scrollViewDelegate scrollViewDidScroll:tableView];
}

- (void)scrollViewDidZoom:(BVTTableView *)tableView {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewDidZoom:)])
        [tableView.scrollViewDelegate scrollViewDidZoom:tableView];
}

- (void)scrollViewWillBeginDragging:(BVTTableView *)tableView {
    [tableView endEditing:YES];
    
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)])
        [tableView.scrollViewDelegate scrollViewWillBeginDragging:tableView];
}

- (void)scrollViewWillEndDragging:(BVTTableView *)tableView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)])
        [tableView.scrollViewDelegate scrollViewWillEndDragging:tableView withVelocity:velocity targetContentOffset:targetContentOffset];
}

- (void)scrollViewDidEndDragging:(BVTTableView *)tableView willDecelerate:(BOOL)decelerate {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
        [tableView.scrollViewDelegate scrollViewDidEndDragging:tableView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDecelerating:(BVTTableView *)tableView {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)])
        [tableView.scrollViewDelegate scrollViewWillBeginDecelerating:tableView];
}

- (void)scrollViewDidEndDecelerating:(BVTTableView *)tableView {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
        [tableView.scrollViewDelegate scrollViewDidEndDecelerating:tableView];
}


- (void)scrollViewDidEndScrollingAnimation:(BVTTableView *)tableView {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)])
        [tableView.scrollViewDelegate scrollViewDidEndScrollingAnimation:tableView];
}

- (UIView *)viewForZoomingInScrollView:(BVTTableView *)tableView {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)])
        return [tableView.scrollViewDelegate viewForZoomingInScrollView:tableView];
    return nil;
}

- (void)scrollViewWillBeginZooming:(BVTTableView *)tableView withView:(UIView *)view {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)])
        [tableView.scrollViewDelegate scrollViewWillBeginZooming:tableView withView:view];
}


- (void)scrollViewDidEndZooming:(BVTTableView *)tableView withView:(UIView *)view atScale:(CGFloat)scale {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)])
        [tableView.scrollViewDelegate scrollViewDidEndZooming:tableView withView:view atScale:scale];
}


- (BOOL)scrollViewShouldScrollToTop:(BVTTableView *)tableView {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)])
        return [tableView.scrollViewDelegate scrollViewShouldScrollToTop:tableView];
    
    return YES;
}


- (void)scrollViewDidScrollToTop:(BVTTableView *)tableView {
    if ([tableView.scrollViewDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)])
        [tableView.scrollViewDelegate scrollViewDidScrollToTop:tableView];
}

@end
