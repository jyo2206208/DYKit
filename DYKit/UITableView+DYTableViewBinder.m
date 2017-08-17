//
//  UITableView+DYTableViewBinder.m
//  DYMVVMRAC
//
//  Created by DuYe on 2017/6/30.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "UITableView+DYTableViewBinder.h"

@implementation UITableView (DYTableViewBinder)

#pragma 隐形代理
DYSYNTH_DYNAMIC_PROPERTY_OBJECT(dy_agent, setDy_agent, RETAIN, DYTableViewAgent *)

- (id)dy_data{return self.dy_agent.data;}
- (void)setDy_data:(id)dy_data{self.dy_agent.data = dy_data;}

#pragma 主要装配方法
- (DYTableViewModule*) assembly:(AssemblyBlock)block{
    return [self assembly:block fromSlot:^BOOL(NSIndexPath *indexPath, id model) {
        return YES;
    } withPlug:UITableViewCell.class];
}

- (DYTableViewModule*) assembly:(AssemblyBlock)block withPlug:(Class)plug{
    return [self assembly:block fromSlot:^BOOL(NSIndexPath *indexPath, id model) {
        return YES;
    } withPlug:plug];
}

- (DYTableViewModule*) assembly:(AssemblyBlock)assemblyBlock fromSlot:(SlotBlock)slotBlock{
    return [self assembly:assemblyBlock fromSlot:slotBlock withPlug:UITableViewCell.class];
}

- (DYTableViewModule*) assembly:(AssemblyBlock)assemblyBlock fromSlot:(SlotBlock)slotBlock withPlug:(Class)plug{
    if (!self.dy_agent) {
        self.dy_agent = [[DYTableViewAgent alloc] init];
        self.dataSource = self.dy_agent;
        self.delegate = self.dy_agent;
        @weakify(self)
        [[RACObserve(self, dy_agent.data) skip:1] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            [self reloadData];
        }];
    }
    [self dyRegisterForCellReuseIdentifier:NSStringFromClass(plug)];
    DYTableViewModule *module = [[DYTableViewModule alloc] init];
    module.reuseIdentifier = NSStringFromClass(plug);
    module.slotBlock = slotBlock;
    module.assemblyBlock = assemblyBlock;
    
    NSUInteger __block count = self.dy_agent.tableModuleLists.count;
    [self.dy_agent.tableModuleLists addObject:module];
    @weakify(self)
    [RACObserve(module, self) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.dy_agent.tableModuleLists replaceObjectAtIndex:count withObject:module];
    }];
    return module;
}

- (void)dyRegisterForCellReuseIdentifier:(NSString *)identifier{
    if ([[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"]) {
        [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    } else {
        [self registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
    }
}

#pragma 配置用block
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
- (UITableView*)setViewForHeaderInSection:(UIViewTableViewNSInteger)block{self.dy_agent.viewForHeaderInSection = block;return self;}
- (UITableView*)setViewForFooterInSection:(UIViewTableViewNSInteger)block{self.dy_agent.viewForFooterInSection = block;return self;}
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

#pragma DataSource方法
- (RACSignal*)commitEditingStyleSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)];
}
- (RACSignal*)moveRowAtIndexPathSignal{
    return [self.dy_agent rac_signalForSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)];
}

@end
