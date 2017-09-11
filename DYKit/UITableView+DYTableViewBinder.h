//
//  UITableView+DYTableViewBinder.h
//  DYMVVMRAC
//
//  Created by DuYe on 2017/6/30.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYTableViewAgent.h"
#import "objc/runtime.h"
#import "DYTableViewRowAction.h"

@interface UITableView (DYTableViewBinder)

#pragma 属性

/**
 隐形代理
 */
@property (nonatomic, strong) DYTableViewAgent *agent;

/**
 是否在给data赋值后自动执行reload
 */
@property (nonatomic) BOOL autoReload;

- (NSArray *)data;
- (void)setData:(NSArray *)data;

- (UITableView*)setSectionData:(GetSectionData)block;

#pragma 主要装配方法
/**
 所有cell为UItableViewCell

 @param block 装配用block
 @return 模块本体，可在返回后继续链式调用配置
 */
- (DYTableViewModule*) assembly:(AssemblyBlock)block;

/**
 所有cell为参数plug所指的cell

 @param block 装配用block
 @param plug 装配用cell类型
 @return 模块本体，可在返回后继续链式调用配置
 */
- (DYTableViewModule*) assembly:(AssemblyBlock)block withPlug:(Class)plug;

/**
 满足slotBlock条件的位置装配UItableViewCell

 @param assemblyBlock 装配用block
 @param slotBlock 装配条件block
 @return 模块本体，可在返回后继续链式调用配置
 */
- (DYTableViewModule*) assembly:(AssemblyBlock)assemblyBlock fromSlot:(SlotBlock)slotBlock;

/**
 满足slotBlock条件的位置装配参数plug所指的cell

 @param assemblyBlock 装配用block
 @param slotBlock 装配条件block
 @param plug 装配用cell类型
 @return 模块本体，可在返回后继续链式调用配置
 */
- (DYTableViewModule*) assembly:(AssemblyBlock)assemblyBlock fromSlot:(SlotBlock)slotBlock withPlug:(Class)plug;


#pragma 配置用block
- (UITableView*)setHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block;
- (UITableView*)setEditActionsForRowAtIndexPath:(EditActionsForRowAtIndexPath)block;
- (UITableView*)setShouldHighlightRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setCanEditRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setNumberOfRowsInSection:(NSIntegerTableViewIndexPath)block;
//- (void)setCellForRowAtIndexPath:(UITableViewCellTableViewIndexPath)block;
- (UITableView*)setNumberOfSectionsInTableView:(NSIntegerUITableView)block;
- (UITableView*)setTitleForHeaderInSection:(NSStringTableViewNSInteger)block;
- (UITableView*)setTitleForFooterInSection:(NSStringTableViewNSInteger)block;
- (UITableView*)setCanMoveRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setSectionIndexTitlesForTableView:(SectionIndexTitlesForTableView)block;
- (UITableView*)setSectionForSectionIndexTitle:(NSIntegerUITableViewNSStringNSInteger)block;
- (UITableView*)setHeightForHeaderInSection:(CGFloatTableViewNSInteger)block;
- (UITableView*)setHeightForFooterInSection:(CGFloatTableViewNSInteger)block;
- (UITableView*)setEstimatedHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block;
- (UITableView*)setEstimatedHeightForHeaderInSection:(CGFloatTableViewNSInteger)block;
- (UITableView*)setEstimatedHeightForFooterInSection:(CGFloatTableViewNSInteger)block;
- (UITableView*)setViewForHeaderInSection:(UIViewTableViewNSInteger)block;
- (UITableView*)setViewForFooterInSection:(UIViewTableViewNSInteger)block;
- (UITableView*)setWillSelectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block;
- (UITableView*)setWillDeselectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block;
- (UITableView*)setEditingStyleForRowAtIndexPath:(UITableViewCellEditingStyleUITableViewNSIndexPath)block;
//- (UITableView*)setTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSStringTableViewIndexPath)block;
- (UITableView*)setShouldIndentWhileEditingRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setTargetIndexPathForMoveFromRowAtIndexPath:(NSIndexPathUITableViewNSIndexPathNSIndexPath)block;
- (UITableView*)setIndentationLevelForRowAtIndexPath:(NSIntegerUITableViewNSIndexPath)block;
- (UITableView*)setShouldShowMenuForRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setCanPerformAction:(BOOLUITableViewSELNSIndexPath)block;
- (UITableView*)setCanFocusRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (UITableView*)setShouldUpdateFocusInContext:(BOOLUITableViewFocusUpdateContext)block;
- (UITableView*)setIndexPathForPreferredFocusedViewInTableView:(NSIndexPathUITableView)block;

#pragma delegate方法
- (RACSignal*)accessoryButtonTappedForRowWithIndexPathSignal;
- (RACSignal*)didEndDisplayingCellSignal;
- (RACSignal*)didEndDisplayingHeaderViewSignal;
- (RACSignal*)didEndDisplayingFooterViewSignal;
- (RACSignal*)didHighlightRowAtIndexPathSignal;
- (RACSignal*)didUnhighlightRowAtIndexPathSignal;
- (RACSignal*)didSelectRowAtIndexPathSignal;
- (RACSignal*)didDeselectRowAtIndexPathSignal;
- (RACSignal*)didEndEditingRowAtIndexPathSignal;
- (RACSignal*)didUpdateFocusInContextSignal;
- (RACSignal*)performActionSignal;
- (RACSignal*)willBeginEditingRowAtIndexPathSignal;
- (RACSignal*)willDisplayCellSignal;
- (RACSignal*)willDisplayHeaderViewSignal;
- (RACSignal*)willDisplayFooterViewSignal;

#pragma DataSource方法
- (RACSignal*)commitEditingStyleSignal;
- (RACSignal*)moveRowAtIndexPathSignal;



@end
