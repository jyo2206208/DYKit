//
//  UITableView+DYTableViewBinder.m
//  DYMVVMRAC
//
//  Created by DuYe on 2017/6/30.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "UITableView+DYTableViewBinder.h"



@implementation UITableView (DYTableViewBinder)

- (DYTableViewAgent *)dy_agent {
    DYTableViewAgent *_agent = objc_getAssociatedObject(self, @selector(dy_agent));
    if (!_agent) {
        _agent = [DYTableViewAgent new];
        objc_setAssociatedObject(self, @selector(dy_agent), _agent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.dataSource = _agent;
        self.delegate = _agent;
        @weakify(self)
        [[RACObserve(self, reload) skip:1] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            [self reloadData];
        }];
    }
    return _agent;
}

- (void)setReload:(id)reload {
    [self willChangeValueForKey:@"reload"];
    objc_setAssociatedObject(self, @selector(reload), reload, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"reload"];
}

- (id)reload {
    return objc_getAssociatedObject(self, @selector(reload));
}

- (id (^)(NSIndexPath *))modelOfCellAtIndexPath {
    return self.dy_agent.modelOfCellAtIndexPath;
}

- (id (^)(NSInteger))modelOfHeaderAtSection {
    return self.dy_agent.modelOfHeaderAtSection;
}

- (id (^)(NSInteger))modelOfFooterAtSection {
    return self.dy_agent.modelOfFooterAtSection;
}

- (void)setModelOfCellAtIndexPath:(id (^)(NSIndexPath *))modelOfCellAtIndexPath {
    self.dy_agent.modelOfCellAtIndexPath = modelOfCellAtIndexPath;
}

- (void)setModelOfHeaderAtSection:(id (^)(NSInteger))modelOfHeaderAtSection {
    self.dy_agent.modelOfHeaderAtSection = modelOfHeaderAtSection;
}

- (void)setModelOfFooterAtSection:(id (^)(NSInteger))modelOfFooterAtSection {
    self.dy_agent.modelOfFooterAtSection = modelOfFooterAtSection;
}

#pragma 主要配置方法
- (UITableView*) assemblyWithAssemblyBlock:(AssemblyBlock)block{
    return [self assemblyByReuseIdentifier:DY_DEFAULT_ID withAssemblyBlock:block];
}

- (UITableView*) assemblyByReuseIdentifier:(NSString *)identifier withAssemblyBlock:(AssemblyBlock)block{
    return [self addReuseIdentifier:identifier FromSlot:^BOOL(NSIndexPath *indexPath, id model) {
        return YES;
    } withAssemblyBlock:block];
}

- (UITableView*) addReuseIdentifier:(NSString *)identifier FromSection:(int)section row:(int)row withAssemblyBlock:(AssemblyBlock)block{
    return [self addReuseIdentifier:identifier FromSlot:^BOOL(NSIndexPath *indexPath, id model) {
        return indexPath.section == section && indexPath.row == row;
    } withAssemblyBlock:block];
}

- (UITableView*) addReuseIdentifier:(NSString *)identifier FromSection:(int)section withAssemblyBlock:(AssemblyBlock)block{
    return [self addReuseIdentifier:identifier FromSlot:^BOOL(NSIndexPath *indexPath, id model) {
        return indexPath.section == section;
    } withAssemblyBlock:block];
}
- (UITableView*) addReuseIdentifier:(NSString *)identifier FromRow:(int)row withAssemblyBlock:(AssemblyBlock)block{
    return [self addReuseIdentifier:identifier FromSlot:^BOOL(NSIndexPath *indexPath, id model) {
        return indexPath.section == 0 && indexPath.row == row;
    } withAssemblyBlock:block];
}

- (UITableView*) addReuseIdentifier:(NSString *)identifier FromSlot:(SlotBlock)slotBlock withAssemblyBlock:(AssemblyBlock)cellBindBlock{
    [self dyRegisterForCellReuseIdentifier:identifier];
    CellInfo *cellInfo = [[CellInfo alloc] init];
    cellInfo.reuseIdentifier = identifier;
    cellInfo.slotBlock = slotBlock;
    cellInfo.cellBindBlock = cellBindBlock;
    [self.dy_agent.cellInfoList addObject:cellInfo];
    return self;
}

- (void)dyRegisterForCellReuseIdentifier:(NSString *)identifier{
    if ([identifier isEqualToString:DY_DEFAULT_ID]) {
        [self registerClass:UITableViewCell.class forCellReuseIdentifier:identifier];
    } else {
        UINib *xib = [UINib nibWithNibName:identifier bundle:nil];
        if (xib) {
            [self registerNib:xib forCellReuseIdentifier:identifier];
        } else {
            [self registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
        }
    }
}

#pragma 配置用block
//- (CGFloatTableViewIndexPath)heightForRowAtIndexPath{return self.dy_agent.heightForRowAtIndexPath;}
//- (EditActionsForRowAtIndexPath)editActionsForRowAtIndexPath{return self.dy_agent.editActionsForRowAtIndexPath;}
//- (BOOLTableViewIndexPath)shouldHighlightRowAtIndexPath{return self.dy_agent.shouldHighlightRowAtIndexPath;}
//- (BOOLTableViewIndexPath)canEditRowAtIndexPath{return self.dy_agent.canEditRowAtIndexPath;}
//- (NSIntegerTableViewIndexPath)numberOfRowsInSection{return self.dy_agent.numberOfRowsInSection;}
////- (UITableViewCellTableViewIndexPath)cellForRowAtIndexPath{return self.dy_agent.cellForRowAtIndexPath;}
//- (NSIntegerUITableView)numberOfSectionsInTableView{return self.dy_agent.numberOfSectionsInTableView;}
//- (NSStringTableViewNSInteger)titleForHeaderInSection{return self.dy_agent.titleForHeaderInSection;}
//- (NSStringTableViewNSInteger)titleForFooterInSection{return self.dy_agent.titleForFooterInSection;}
//- (BOOLTableViewIndexPath)canMoveRowAtIndexPath{return self.dy_agent.canMoveRowAtIndexPath;}
//- (SectionIndexTitlesForTableView)sectionIndexTitlesForTableView{return self.dy_agent.sectionIndexTitlesForTableView;}
//- (NSIntegerUITableViewNSStringNSInteger)sectionForSectionIndexTitle{return self.dy_agent.sectionForSectionIndexTitle;}
//- (CGFloatTableViewNSInteger)heightForHeaderInSection{return self.dy_agent.heightForHeaderInSection;}
//- (CGFloatTableViewNSInteger)heightForFooterInSection{return self.dy_agent.heightForFooterInSection;}
//- (CGFloatTableViewIndexPath)estimatedHeightForRowAtIndexPath{return self.dy_agent.estimatedHeightForRowAtIndexPath;}
//- (CGFloatTableViewNSInteger)estimatedHeightForHeaderInSection{return self.dy_agent.estimatedHeightForHeaderInSection;}
//- (CGFloatTableViewNSInteger)estimatedHeightForFooterInSection{return self.dy_agent.estimatedHeightForFooterInSection;}
//- (UIViewTableViewHeaderFooterBlock)viewForHeaderInSection{return self.dy_agent.viewForHeaderInSection;}
//- (UIViewTableViewHeaderFooterBlock)viewForFooterInSection{return self.dy_agent.viewForFooterInSection;}
//- (NSIndexPathUITableViewNSIndexPath)willSelectRowAtIndexPath{return self.dy_agent.willSelectRowAtIndexPath;}
//- (NSIndexPathUITableViewNSIndexPath)willDeselectRowAtIndexPath{return self.dy_agent.willDeselectRowAtIndexPath;}
//- (UITableViewCellEditingStyleUITableViewNSIndexPath)editingStyleForRowAtIndexPath{return self.dy_agent.editingStyleForRowAtIndexPath;}
//- (NSStringTableViewIndexPath)titleForDeleteConfirmationButtonForRowAtIndexPath{return self.dy_agent.titleForDeleteConfirmationButtonForRowAtIndexPath;}
//- (BOOLTableViewIndexPath)shouldIndentWhileEditingRowAtIndexPath{return self.dy_agent.shouldIndentWhileEditingRowAtIndexPath;}
//- (NSIndexPathUITableViewNSIndexPathNSIndexPath)targetIndexPathForMoveFromRowAtIndexPath{return self.dy_agent.targetIndexPathForMoveFromRowAtIndexPath;}
//- (NSIntegerUITableViewNSIndexPath)indentationLevelForRowAtIndexPath{return self.dy_agent.indentationLevelForRowAtIndexPath;}
//- (BOOLTableViewIndexPath)shouldShowMenuForRowAtIndexPath{return self.dy_agent.shouldShowMenuForRowAtIndexPath;}
//- (BOOLUITableViewSELNSIndexPath)canPerformAction{return self.dy_agent.canPerformAction;}
//- (BOOLTableViewIndexPath)canFocusRowAtIndexPath{return self.dy_agent.canFocusRowAtIndexPath;}
//- (BOOLUITableViewFocusUpdateContext)shouldUpdateFocusInContext{return self.dy_agent.shouldUpdateFocusInContext;}
//- (NSIndexPathUITableView)indexPathForPreferredFocusedViewInTableView{return self.dy_agent.indexPathForPreferredFocusedViewInTableView;}
- (UITableView*)setHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block{self.dy_agent.heightForRowAtIndexPath = block;return self;}
- (UITableView*)setEditActionsForRowAtIndexPath:(EditActionsForRowAtIndexPath)block{self.dy_agent.editActionsForRowAtIndexPath = block;return self;}
- (UITableView*)setShouldHighlightRowAtIndexPath:(BOOLTableViewIndexPath)block{self.dy_agent.shouldHighlightRowAtIndexPath = block;return self;}
- (UITableView*)setCanEditRowAtIndexPath:(BOOLTableViewIndexPath)block{self.dy_agent.canEditRowAtIndexPath = block;return self;}
- (UITableView*)setNumberOfRowsInSection:(NSIntegerTableViewIndexPath)block{self.dy_agent.numberOfRowsInSection = block;return self;}
//- (void)setCellForRowAtIndexPath:(UITableViewCellTableViewIndexPath)block{self.dy_agent.cellForRowAtIndexPath = block;}
- (UITableView*)setNumberOfSectionsInTableView:(NSIntegerUITableView)block{self.dy_agent.numberOfSectionsInTableView = block;return self;}
- (UITableView*)setTitleForHeaderInSection:(NSStringTableViewNSInteger)block{self.dy_agent.titleForHeaderInSection = block;return self;}
- (UITableView*)setTitleForFooterInSection:(NSStringTableViewNSInteger)block{self.dy_agent.titleForFooterInSection = block;return self;}
- (UITableView*)setCanMoveRowAtIndexPath:(BOOLTableViewIndexPath)block{self.dy_agent.canMoveRowAtIndexPath = block;return self;}
- (UITableView*)setSectionIndexTitlesForTableView:(SectionIndexTitlesForTableView)block{self.dy_agent.sectionIndexTitlesForTableView = block;return self;}
- (UITableView*)setSectionForSectionIndexTitle:(NSIntegerUITableViewNSStringNSInteger)block{self.dy_agent.sectionForSectionIndexTitle = block;return self;}
- (UITableView*)setHeightForHeaderInSection:(CGFloatTableViewNSInteger)block{self.dy_agent.heightForHeaderInSection = block;return self;}
- (UITableView*)setHeightForFooterInSection:(CGFloatTableViewNSInteger)block{self.dy_agent.heightForFooterInSection = block;return self;}
- (UITableView*)setEstimatedHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block{self.dy_agent.estimatedHeightForRowAtIndexPath = block;return self;}
- (UITableView*)setEstimatedHeightForHeaderInSection:(CGFloatTableViewNSInteger)block{self.dy_agent.estimatedHeightForHeaderInSection = block;return self;}
- (UITableView*)setEstimatedHeightForFooterInSection:(CGFloatTableViewNSInteger)block{self.dy_agent.estimatedHeightForFooterInSection = block;return self;}
- (UITableView*)setViewForHeaderInSection:(UIViewTableViewHeaderFooterBlock)block{self.dy_agent.viewForHeaderInSection = block;return self;}
- (UITableView*)setViewForFooterInSection:(UIViewTableViewHeaderFooterBlock)block{self.dy_agent.viewForFooterInSection = block;return self;}
- (UITableView*)setWillSelectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block{self.dy_agent.willSelectRowAtIndexPath = block;return self;}
- (UITableView*)setWillDeselectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block{self.dy_agent.willDeselectRowAtIndexPath = block;return self;}
- (UITableView*)setEditingStyleForRowAtIndexPath:(UITableViewCellEditingStyleUITableViewNSIndexPath)block{self.dy_agent.editingStyleForRowAtIndexPath = block;return self;}
- (UITableView*)setTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSStringTableViewIndexPath)block{self.dy_agent.titleForDeleteConfirmationButtonForRowAtIndexPath = block;return self;}
- (UITableView*)setShouldIndentWhileEditingRowAtIndexPath:(BOOLTableViewIndexPath)block{self.dy_agent.shouldIndentWhileEditingRowAtIndexPath = block;return self;}
- (UITableView*)setTargetIndexPathForMoveFromRowAtIndexPath:(NSIndexPathUITableViewNSIndexPathNSIndexPath)block{self.dy_agent.targetIndexPathForMoveFromRowAtIndexPath = block;return self;}
- (UITableView*)setIndentationLevelForRowAtIndexPath:(NSIntegerUITableViewNSIndexPath)block{self.dy_agent.indentationLevelForRowAtIndexPath = block;return self;}
- (UITableView*)setShouldShowMenuForRowAtIndexPath:(BOOLTableViewIndexPath)block{self.dy_agent.shouldShowMenuForRowAtIndexPath = block;return self;}
- (UITableView*)setCanPerformAction:(BOOLUITableViewSELNSIndexPath)block{self.dy_agent.canPerformAction = block;return self;}
- (UITableView*)setCanFocusRowAtIndexPath:(BOOLTableViewIndexPath)block{self.dy_agent.canFocusRowAtIndexPath = block;return self;}
- (UITableView*)setShouldUpdateFocusInContext:(BOOLUITableViewFocusUpdateContext)block{self.dy_agent.shouldUpdateFocusInContext = block;return self;}
- (UITableView*)setIndexPathForPreferredFocusedViewInTableView:(NSIndexPathUITableView)block{self.dy_agent.indexPathForPreferredFocusedViewInTableView = block;return self;}

#pragma delegate方法
- (RACSignal*)accessoryButtonTappedForRowWithIndexPathSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)];
}
- (RACSignal*)didEndDisplayingCellSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)];
}
- (RACSignal*)didEndDisplayingHeaderViewSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)];
}
- (RACSignal*)didEndDisplayingFooterViewSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)];
}
- (RACSignal*)didHighlightRowAtIndexPathSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:didHighlightRowAtIndexPath:)];
}
- (RACSignal*)didUnhighlightRowAtIndexPathSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)];
}
- (RACSignal*)didSelectRowAtIndexPathSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:)];
}
- (RACSignal*)didDeselectRowAtIndexPathSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:didDeselectRowAtIndexPath:)];
}
- (RACSignal*)didEndEditingRowAtIndexPathSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:didEndEditingRowAtIndexPath:)];
}
- (RACSignal*)didUpdateFocusInContextSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:didUpdateFocusInContext:withAnimationCoordinator:)];
}
- (RACSignal*)performActionSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)];
}
- (RACSignal*)willBeginEditingRowAtIndexPathSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)];
}
- (RACSignal*)willDisplayCellSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)];
}
- (RACSignal*)willDisplayHeaderViewSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:willDisplayHeaderView:forSection:)];
}
- (RACSignal*)willDisplayFooterViewSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:willDisplayFooterView:forSection:)];
}

- (RACSignal*)scrollViewDidScrollSignal {
    return [self.dy_agent rac_signalForSelector:@selector(scrollViewDidScroll:)];
}
- (RACSignal*)scrollViewWillBeginDraggingSignal {
    return [self.dy_agent rac_signalForSelector:@selector(scrollViewWillBeginDragging:)];
}

#pragma DataSource方法
- (RACSignal*)commitEditingStyleSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)];
}
- (RACSignal*)moveRowAtIndexPathSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)];
}

@end
