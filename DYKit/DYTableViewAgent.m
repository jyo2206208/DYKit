//
//  DYTableViewDataSouce.m
//  DYMVVMRAC
//
//  Created by DuYe on 2017/7/7.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "DYTableViewAgent.h"

@implementation DYTableViewAgent

#pragma lazyProperties
DYN_LAZY(tableModuleLists, NSMutableArray)
- (DYTableViewModule *)defaultTableModule
{
    return DY_LAZY(_defaultTableModule,({
        DYTableViewModule *module = [[DYTableViewModule alloc] init];
        module.reuseIdentifier = @"UITableViewCell";
        module.slotBlock = ^BOOL(NSIndexPath *indexPath, id model) {return YES;};
        module;
    }));
}

#pragma dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //第一优先级 用户局部block定制
    if (self.numberOfRowsInSection) {
        return self.numberOfRowsInSection(tableView, section);
    }
    //第二优先级 sectionData
    if (self.getSectionData) {
        return self.getSectionData(self.data[section],section).count;
    }
    //第三优先级 默认值
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (self.getSectionData) {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.getSectionData(self.data[indexPath.section],indexPath.section)[indexPath.row])) {
                cell = [tableView dequeueReusableCellWithIdentifier:module.reuseIdentifier];
                module.assemblyBlock(cell, self.getSectionData(self.data[indexPath.section],indexPath.section)[indexPath.row], indexPath);
                return cell;
            }
        }
    } else {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.data[indexPath.row])) {
                cell = [tableView dequeueReusableCellWithIdentifier:module.reuseIdentifier];
                module.assemblyBlock(cell, self.data[indexPath.row], indexPath);
                return cell;
            }
        }
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:self.defaultTableModule.reuseIdentifier];
    
    if (self.getSectionData) {
        self.defaultTableModule.assemblyBlock(cell, self.getSectionData(self.data[indexPath.section],indexPath.section)[indexPath.row], indexPath);
        return cell;
    } else {
        self.defaultTableModule.assemblyBlock(cell, self.data[indexPath.row], indexPath);
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //第一优先级 用户局部block定制
    if (self.numberOfSectionsInTableView) {
        return self.numberOfSectionsInTableView(tableView);
    }
    //第二优先级 sectionData
    if (self.getSectionData) {
        return self.data.count;
    }
    //第三优先级 默认值
    return 1;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    //第一优先级 用户局部block定制
    if (self.canEditRowAtIndexPath) {
        return self.canEditRowAtIndexPath(tableView, indexPath);
    }
    //第二优先级 用户局部定制
    if (self.getSectionData) {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.getSectionData(self.data[indexPath.section],indexPath.section)[indexPath.row])) {
                if (module.editing) {
                    return module.editing;
                }
            }
        }
    } else {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.data[indexPath.row])) {
                if (module.editing) {
                    return module.editing;
                }
            }
        }
    }
    //第三优先级 默认全局定制
    if (self.defaultTableModule) {
        return self.defaultTableModule.editing;
    }
    //第四优先级 默认值
    return tableView.editing;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.titleForHeaderInSection ? self.titleForHeaderInSection(tableView,section) : nil;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return self.titleForFooterInSection ? self.titleForFooterInSection(tableView,section) : nil;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.canMoveRowAtIndexPath ? self.canMoveRowAtIndexPath(tableView,indexPath) : NO;
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionIndexTitlesForTableView ? self.sectionIndexTitlesForTableView(tableView) : nil;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return self.sectionForSectionIndexTitle ? self.sectionForSectionIndexTitle(tableView,title,index) : 0;
}


#pragma delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //第一优先级 用户局部block定制
    if (self.heightForRowAtIndexPath) {
        return self.heightForRowAtIndexPath(tableView, indexPath);
    }
    //第二优先级 用户局部定制
    if (self.getSectionData) {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.getSectionData(self.data[indexPath.section],indexPath.section)[indexPath.row])) {
                if (module.rowHeight) {
                    return module.rowHeight;
                }
            }
        }
    } else {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.data[indexPath.row])) {
                if (module.rowHeight) {
                    return module.rowHeight;
                }
            }
        }
    }
    //第三优先级 默认全局定制
    if (self.defaultTableModule) {
        if (self.defaultTableModule.rowHeight) {
            return self.defaultTableModule.rowHeight;
        }
    }
    //第四优先级 默认值
    return tableView.rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.heightForHeaderInSection ? self.heightForHeaderInSection(tableView,section) : tableView.sectionHeaderHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.heightForFooterInSection ? self.heightForFooterInSection(tableView,section) : tableView.sectionFooterHeight;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0){
    //第一优先级 用户局部block定制
    if (self.estimatedHeightForRowAtIndexPath) {
        return self.estimatedHeightForRowAtIndexPath(tableView, indexPath);
    }
    //第二优先级 用户局部定制
    if (self.getSectionData) {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.getSectionData(self.data[indexPath.section],indexPath.section)[indexPath.row])) {
                if (module.estimatedHeight) {
                    return module.estimatedHeight;
                }
            }
        }
    } else {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.data[indexPath.row])) {
                if (module.estimatedHeight) {
                    return module.estimatedHeight;
                }
            }
        }
    }
    //第三优先级 默认全局定制
    if (self.defaultTableModule) {
        if (self.defaultTableModule.estimatedHeight) {
            return self.defaultTableModule.estimatedHeight;
        }
    }
    //第四优先级 默认值
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0){
    return self.estimatedHeightForHeaderInSection ? self.estimatedHeightForHeaderInSection(tableView,section) : [self tableView:tableView heightForHeaderInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0){
    return self.estimatedHeightForFooterInSection ? self.estimatedHeightForFooterInSection(tableView,section) : [self tableView:tableView heightForFooterInSection:section];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.viewForHeaderInSection ? self.viewForHeaderInSection(tableView,section) : nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.viewForFooterInSection ? self.viewForFooterInSection(tableView,section) : nil;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0){
    return self.shouldHighlightRowAtIndexPath ? self.shouldHighlightRowAtIndexPath(tableView,indexPath) : YES;
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.willSelectRowAtIndexPath ? self.willSelectRowAtIndexPath(tableView,indexPath) : indexPath;
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
    return self.willDeselectRowAtIndexPath ? self.willDeselectRowAtIndexPath(tableView,indexPath) : indexPath;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self tableView:tableView canEditRowAtIndexPath:indexPath ]) {
        //第一优先级 用户局部block定制
        if (self.editingStyleForRowAtIndexPath) {
            return self.editingStyleForRowAtIndexPath(tableView, indexPath);
        }
        //第二优先级 用户局部定制
        if (self.getSectionData) {
            for (DYTableViewModule *module in self.tableModuleLists) {
                if (module.slotBlock(indexPath,self.getSectionData(self.data[indexPath.section],indexPath.section)[indexPath.row])) {
                    if (module.editingStyle) {
                        return module.editingStyle;
                    }
                }
            }
        } else {
            for (DYTableViewModule *module in self.tableModuleLists) {
                if (module.slotBlock(indexPath,self.data[indexPath.row])) {
                    if (module.editingStyle) {
                        return module.editingStyle;
                    }
                }
            }
        }
        //第三优先级 默认全局定制
        if (self.defaultTableModule) {
            if (self.defaultTableModule.editingStyle) {
                return self.defaultTableModule.editingStyle;
            }
        }
        
        return UITableViewCellEditingStyleDelete;
    }
    //第四优先级 默认值
    return UITableViewCellEditingStyleNone;
}




//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED{
//    return self.titleForDeleteConfirmationButtonForRowAtIndexPath ? self.titleForDeleteConfirmationButtonForRowAtIndexPath(tableView,indexPath) : nil;
//}




- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{
    //第一优先级 用户局部block定制
    if (self.editActionsForRowAtIndexPath) {
        return self.editActionsForRowAtIndexPath(tableView,indexPath);
    }
    //第二优先级 用户局部定制
    if (self.getSectionData) {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.getSectionData(self.data[indexPath.section],indexPath.section)[indexPath.row])) {
                if (module.editActions) {
                    NSMutableArray<UITableViewRowAction *> *array = [[NSMutableArray alloc] init];
                    for (DYTableViewRowAction *dyAction in module.editActions) {
                        [array addObject:[UITableViewRowAction rowActionWithStyle:dyAction.accessibilityPerformMagicTap title:dyAction.title handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                            dyAction.handler(action, self.data[indexPath.row], indexPath);
                        }]];
                    }
                    return array;
                }
            }
        }
    } else {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.data[indexPath.row])) {
                if (module.editActions) {
                    NSMutableArray<UITableViewRowAction *> *array = [[NSMutableArray alloc] init];
                    for (DYTableViewRowAction *dyAction in module.editActions) {
                        [array addObject:[UITableViewRowAction rowActionWithStyle:dyAction.accessibilityPerformMagicTap title:dyAction.title handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                            dyAction.handler(action, self.data[indexPath.row], indexPath);
                        }]];
                    }
                    return array;
                }
            }
        }
    }
    //第三优先级 默认全局定制
    if (self.defaultTableModule) {
        if (self.defaultTableModule.editActions) {
            NSMutableArray<UITableViewRowAction *> *array = [[NSMutableArray alloc] init];
            for (DYTableViewRowAction *dyAction in self.defaultTableModule.editActions) {
                [array addObject:[UITableViewRowAction rowActionWithStyle:dyAction.accessibilityPerformMagicTap title:dyAction.title handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                    dyAction.handler(action, self.data[indexPath.row], indexPath);
                }]];
            }
            return array;
        }
    }
    //第四优先级 默认值
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.shouldIndentWhileEditingRowAtIndexPath ? self.shouldIndentWhileEditingRowAtIndexPath(tableView,indexPath) : YES;
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    return self.targetIndexPathForMoveFromRowAtIndexPath ? self.targetIndexPathForMoveFromRowAtIndexPath(tableView,sourceIndexPath,proposedDestinationIndexPath) : proposedDestinationIndexPath;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    //第一优先级 用户局部block定制
    if (self.indentationLevelForRowAtIndexPath) {
        return self.indentationLevelForRowAtIndexPath(tableView, indexPath);
    }
    //第二优先级 用户局部定制
    if (self.getSectionData) {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.getSectionData(self.data[indexPath.section],indexPath.section)[indexPath.row])) {
                if (module.indentationLevel) {
                    return module.indentationLevel;
                }
            }
        }
    } else {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.data[indexPath.row])) {
                if (module.indentationLevel) {
                    return module.indentationLevel;
                }
            }
        }
    }
    //第三优先级 默认全局定制
    if (self.defaultTableModule) {
        if (self.defaultTableModule.indentationLevel) {
            return self.defaultTableModule.indentationLevel;
        }
    }
    //第四优先级 默认值
    return 0;
}
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0){
    //第一优先级 用户局部block定制
    if (self.shouldShowMenuForRowAtIndexPath) {
        return self.shouldShowMenuForRowAtIndexPath(tableView, indexPath);
    }
    //第二优先级 用户局部定制
    if (self.getSectionData) {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.getSectionData(self.data[indexPath.section],indexPath.section)[indexPath.row])) {
                if (module.shouldShowMenu) {
                    return module.shouldShowMenu;
                }
            }
        }
    } else {
        for (DYTableViewModule *module in self.tableModuleLists) {
            if (module.slotBlock(indexPath,self.data[indexPath.row])) {
                if (module.shouldShowMenu) {
                    return module.shouldShowMenu;
                }
            }
        }
    }
    //第三优先级 默认全局定制
    if (self.defaultTableModule) {
        if (self.defaultTableModule.shouldShowMenu) {
            return self.defaultTableModule.shouldShowMenu;
        }
    }
    //第四优先级 默认值
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0){
    return self.canPerformAction ? self.canPerformAction(tableView,action,indexPath) : NO;
}
- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
    return self.canFocusRowAtIndexPath ? self.canFocusRowAtIndexPath(tableView,indexPath) : NO;
}
- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0){
    return self.shouldUpdateFocusInContext ? self.shouldUpdateFocusInContext(tableView,context) : NO;
}
- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0){
    return self.indexPathForPreferredFocusedViewInTableView ? self.indexPathForPreferredFocusedViewInTableView(tableView) : nil;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath __TVOS_PROHIBITED{}
- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0){}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0){}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED{}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){}

#pragma 自定义方法

//- (NSInteger)getFlattenRow:(UITableView *)tableView IndexPath:(NSIndexPath*) indexPath{
//    return indexPath.section == 0 ? indexPath.row : [self tableView:tableView numberOfRowsInSection:indexPath.section - 1] + [self getFlattenRow:tableView IndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1]];
//}

@end
