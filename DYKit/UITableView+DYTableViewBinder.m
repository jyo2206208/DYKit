//
//  UITableView+DYTableViewBinder.m
//  DYMVVMRAC
//
//  Created by DuYe on 2017/6/30.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "UITableView+DYTableViewBinder.h"

@implementation UITableView (DYTableViewBinder)

#pragma 属性
DYSYNTH_DYNAMIC_PROPERTY_OBJECT(agent, setAgent, RETAIN, DYTableViewAgent *)
DYSYNTH_DYNAMIC_PROPERTY_CTYPE(autoReload, setAutoReload, BOOL)

- (NSArray *)data{return self.agent.data;}
- (void)setData:(NSArray *)data{self.agent.data = data;}

- (UITableView*)setSectionData:(GetSectionData)block{
    self.agent.getSectionData = block;
    return self;
}

#pragma 主要装配方法
- (DYTableViewModule*) assembly:(AssemblyBlock)block{
    return [self assembly:block withPlug:UITableViewCell.class];
}

- (DYTableViewModule*) assembly:(AssemblyBlock)block withPlug:(Class)plug{
    [self agentInitialize];
    [self dyRegisterForCellReuseIdentifier:NSStringFromClass(plug)];
    self.agent.defaultTableModule.reuseIdentifier = NSStringFromClass(plug);
    self.agent.defaultTableModule.assemblyBlock = block;
    return self.agent.defaultTableModule;
}

- (DYTableViewModule*) assembly:(AssemblyBlock)assemblyBlock fromSlot:(SlotBlock)slotBlock{
    return [self assembly:assemblyBlock fromSlot:slotBlock withPlug:UITableViewCell.class];
}

- (DYTableViewModule*) assembly:(AssemblyBlock)assemblyBlock fromSlot:(SlotBlock)slotBlock withPlug:(Class)plug{
    [self agentInitialize];
    [self dyRegisterForCellReuseIdentifier:NSStringFromClass(plug)];
    DYTableViewModule *module = [[DYTableViewModule alloc] init];
    module.reuseIdentifier = NSStringFromClass(plug);
    module.slotBlock = slotBlock;
    module.assemblyBlock = assemblyBlock;
    
    NSUInteger __block count = self.agent.tableModuleLists.count;
    [self.agent.tableModuleLists addObject:module];
    @weakify(self)
    [RACObserve(module, self) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.agent.tableModuleLists replaceObjectAtIndex:count withObject:module];
    }];
    
    return module;
}

- (void)agentInitialize{
    if (!self.agent) {
        self.agent = [[DYTableViewAgent alloc] init];
        self.dataSource = self.agent;
        self.delegate = self.agent;
        self.autoReload = YES;
        
        @weakify(self)
        RACDisposable __block *reloadDataDisposable = [[RACObserve(self, agent.data) skip:1] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            [self reloadData];
        }];
        
        [[[RACObserve(self, autoReload) skip:1] filter:^BOOL(id  _Nullable value) {
            return [value boolValue] == NO;
        }] subscribeNext:^(id  _Nullable x) {
            [reloadDataDisposable dispose];
        }];
        
        [[[RACObserve(self, autoReload) skip:1] filter:^BOOL(id  _Nullable value) {
            return [value boolValue] == YES;
        }] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            @weakify(self)
            reloadDataDisposable = [[RACObserve(self, agent.data) skip:1] subscribeNext:^(id  _Nullable x) {
                @strongify(self)
                [self reloadData];
            }];
        }];
    }
}

- (void)dyRegisterForCellReuseIdentifier:(NSString *)identifier{
    if ([[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"]) {
        [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    } else {
        [self registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
    }
}

#pragma 配置用block
- (UITableView*)setHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block{[self agentInitialize];self.agent.heightForRowAtIndexPath = block;return self;}
- (UITableView*)setEditActionsForRowAtIndexPath:(EditActionsForRowAtIndexPath)block{[self agentInitialize];self.agent.editActionsForRowAtIndexPath = block;return self;}
- (UITableView*)setShouldHighlightRowAtIndexPath:(BOOLTableViewIndexPath)block{[self agentInitialize];self.agent.shouldHighlightRowAtIndexPath = block;return self;}
- (UITableView*)setCanEditRowAtIndexPath:(BOOLTableViewIndexPath)block{[self agentInitialize];self.agent.canEditRowAtIndexPath = block;return self;}
- (UITableView*)setNumberOfRowsInSection:(NSIntegerTableViewIndexPath)block{[self agentInitialize];self.agent.numberOfRowsInSection = block;return self;}
//- (void)setCellForRowAtIndexPath:(UITableViewCellTableViewIndexPath)block{self.agent.cellForRowAtIndexPath = block;}
- (UITableView*)setNumberOfSectionsInTableView:(NSIntegerUITableView)block{[self agentInitialize];self.agent.numberOfSectionsInTableView = block;return self;}
- (UITableView*)setTitleForHeaderInSection:(NSStringTableViewNSInteger)block{[self agentInitialize];self.agent.titleForHeaderInSection = block;return self;}
- (UITableView*)setTitleForFooterInSection:(NSStringTableViewNSInteger)block{[self agentInitialize];self.agent.titleForFooterInSection = block;return self;}
- (UITableView*)setCanMoveRowAtIndexPath:(BOOLTableViewIndexPath)block{[self agentInitialize];self.agent.canMoveRowAtIndexPath = block;return self;}
- (UITableView*)setSectionIndexTitlesForTableView:(SectionIndexTitlesForTableView)block{[self agentInitialize];self.agent.sectionIndexTitlesForTableView = block;return self;}
- (UITableView*)setSectionForSectionIndexTitle:(NSIntegerUITableViewNSStringNSInteger)block{[self agentInitialize];self.agent.sectionForSectionIndexTitle = block;return self;}
- (UITableView*)setHeightForHeaderInSection:(CGFloatTableViewNSInteger)block{[self agentInitialize];self.agent.heightForHeaderInSection = block;return self;}
- (UITableView*)setHeightForFooterInSection:(CGFloatTableViewNSInteger)block{[self agentInitialize];self.agent.heightForFooterInSection = block;return self;}
- (UITableView*)setEstimatedHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block{[self agentInitialize];self.agent.estimatedHeightForRowAtIndexPath = block;return self;}
- (UITableView*)setEstimatedHeightForHeaderInSection:(CGFloatTableViewNSInteger)block{[self agentInitialize];self.agent.estimatedHeightForHeaderInSection = block;return self;}
- (UITableView*)setEstimatedHeightForFooterInSection:(CGFloatTableViewNSInteger)block{[self agentInitialize];self.agent.estimatedHeightForFooterInSection = block;return self;}
- (UITableView*)setViewForHeaderInSection:(UIViewTableViewNSInteger)block{[self agentInitialize];self.agent.viewForHeaderInSection = block;return self;}
- (UITableView*)setViewForFooterInSection:(UIViewTableViewNSInteger)block{[self agentInitialize];self.agent.viewForFooterInSection = block;return self;}
- (UITableView*)setWillSelectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block{[self agentInitialize];self.agent.willSelectRowAtIndexPath = block;return self;}
- (UITableView*)setWillDeselectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block{[self agentInitialize];self.agent.willDeselectRowAtIndexPath = block;return self;}
- (UITableView*)setEditingStyleForRowAtIndexPath:(UITableViewCellEditingStyleUITableViewNSIndexPath)block{[self agentInitialize];self.agent.editingStyleForRowAtIndexPath = block;return self;}
//- (UITableView*)setTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSStringTableViewIndexPath)block{[self agentInitialize];self.agent.titleForDeleteConfirmationButtonForRowAtIndexPath = block;return self;}
- (UITableView*)setShouldIndentWhileEditingRowAtIndexPath:(BOOLTableViewIndexPath)block{[self agentInitialize];self.agent.shouldIndentWhileEditingRowAtIndexPath = block;return self;}
- (UITableView*)setTargetIndexPathForMoveFromRowAtIndexPath:(NSIndexPathUITableViewNSIndexPathNSIndexPath)block{[self agentInitialize];self.agent.targetIndexPathForMoveFromRowAtIndexPath = block;return self;}
- (UITableView*)setIndentationLevelForRowAtIndexPath:(NSIntegerUITableViewNSIndexPath)block{[self agentInitialize];self.agent.indentationLevelForRowAtIndexPath = block;return self;}
- (UITableView*)setShouldShowMenuForRowAtIndexPath:(BOOLTableViewIndexPath)block{[self agentInitialize];self.agent.shouldShowMenuForRowAtIndexPath = block;return self;}
- (UITableView*)setCanPerformAction:(BOOLUITableViewSELNSIndexPath)block{[self agentInitialize];self.agent.canPerformAction = block;return self;}
- (UITableView*)setCanFocusRowAtIndexPath:(BOOLTableViewIndexPath)block{[self agentInitialize];self.agent.canFocusRowAtIndexPath = block;return self;}
- (UITableView*)setShouldUpdateFocusInContext:(BOOLUITableViewFocusUpdateContext)block{[self agentInitialize];self.agent.shouldUpdateFocusInContext = block;return self;}
- (UITableView*)setIndexPathForPreferredFocusedViewInTableView:(NSIndexPathUITableView)block{[self agentInitialize];self.agent.indexPathForPreferredFocusedViewInTableView = block;return self;}

#pragma delegate方法
- (RACSignal*)accessoryButtonTappedForRowWithIndexPathSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)];
}
- (RACSignal*)didEndDisplayingCellSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)];
}
- (RACSignal*)didEndDisplayingHeaderViewSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)];
}
- (RACSignal*)didEndDisplayingFooterViewSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)];
}
- (RACSignal*)didHighlightRowAtIndexPathSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:didHighlightRowAtIndexPath:)];
}
- (RACSignal*)didUnhighlightRowAtIndexPathSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)];
}
- (RACSignal*)didSelectRowAtIndexPathSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:)];
}
- (RACSignal*)didDeselectRowAtIndexPathSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:didDeselectRowAtIndexPath:)];
}
- (RACSignal*)didEndEditingRowAtIndexPathSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:didEndEditingRowAtIndexPath:)];
}
- (RACSignal*)didUpdateFocusInContextSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:didUpdateFocusInContext:withAnimationCoordinator:)];
}
- (RACSignal*)performActionSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)];
}
- (RACSignal*)willBeginEditingRowAtIndexPathSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)];
}
- (RACSignal*)willDisplayCellSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)];
}
- (RACSignal*)willDisplayHeaderViewSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:willDisplayHeaderView:forSection:)];
}
- (RACSignal*)willDisplayFooterViewSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:willDisplayFooterView:forSection:)];
}

#pragma DataSource方法
- (RACSignal*)commitEditingStyleSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)];
}
- (RACSignal*)moveRowAtIndexPathSignal{
    [self agentInitialize];
    return [self.agent rac_signalForSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)];
}

@end
