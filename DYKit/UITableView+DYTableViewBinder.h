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

@interface UITableView (DYTableViewBinder)

@property (nonatomic, strong) id reload;

@property (nonatomic, strong) id(^modelOfCellAtIndexPath)(NSIndexPath *indexPath);
@property (nonatomic, strong) id(^modelOfHeaderAtSection)(NSInteger section);
@property (nonatomic, strong) id(^modelOfFooterAtSection)(NSInteger section);

#pragma 主要配置方法
/**
 固定UItableViewCell

 @param block cellForRowAtIndexPath的block
 @return 返回自身，用于链式调用
 */
- (UITableView*) assemblyWithAssemblyBlock:(AssemblyBlock)block;

/**
 固定一种自定义cell
 
 @param block cellForRowAtIndexPath的block
 @param identifier cell的重用ID(使用cell的类名，可以是xib或者class创建)
 @return 返回自身，用于链式调用
 */
- (UITableView*) assemblyByReuseIdentifier:(NSString *)identifier withAssemblyBlock:(AssemblyBlock)block;

/**
 指定section和row进行cell设定

 @param identifier cell的重用ID(使用cell的类名，可以是xib或者class创建)
 @param section 指定section位置
 @param row 指定row位置
 @param block cellForRowAtIndexPath的block
 @return 返回自身，用于链式调用
 */
- (UITableView*) addReuseIdentifier:(NSString *)identifier FromSection:(int)section row:(int)row withAssemblyBlock:(AssemblyBlock)block;

/**
 指定section进行cell设定。默认本section下的cell全部按照block内容进行设定

 @param identifier cell的重用ID(使用cell的类名，可以是xib或者class创建)
 @param section 指定section位置
 @param block cellForRowAtIndexPath的block
 @return 返回自身，用于链式调用
 */
- (UITableView*) addReuseIdentifier:(NSString *)identifier FromSection:(int)section withAssemblyBlock:(AssemblyBlock)block;

/**
 指定row进行cell设定。默认只有一个section

 @param identifier cell的重用ID(使用cell的类名，可以是xib或者class创建)
 @param row 指定row位置
 @param block cellForRowAtIndexPath的block
 @return 返回自身，用于链式调用
 */
- (UITableView*) addReuseIdentifier:(NSString *)identifier FromRow:(int)row withAssemblyBlock:(AssemblyBlock)block;

/**
 指定具体的indexPath进行cell设定，可选择任意位置

 @param identifier cell的重用ID(使用cell的类名，可以是xib或者class创建)
 @param slotBlock 用于指定具体条件的block。通过对参数的indexPath进行判断，返回需要的具体位置
 @param cellBindBlock cellForRowAtIndexPath的block
 @return 返回自身，用于链式调用
 */
- (UITableView*) addReuseIdentifier:(NSString *)identifier FromSlot:(SlotBlock)slotBlock withAssemblyBlock:(AssemblyBlock)cellBindBlock;

#pragma 配置用block
//- (CGFloatTableViewIndexPath)heightForRowAtIndexPath;
//- (EditActionsForRowAtIndexPath)editActionsForRowAtIndexPath;
//- (BOOLTableViewIndexPath)shouldHighlightRowAtIndexPath;
//- (BOOLTableViewIndexPath)canEditRowAtIndexPath;
//- (NSIntegerTableViewIndexPath)numberOfRowsInSection;
////- (UITableViewCellTableViewIndexPath)cellForRowAtIndexPath;
//- (NSIntegerUITableView)numberOfSectionsInTableView;
//- (NSStringTableViewNSInteger)titleForHeaderInSection;
//- (NSStringTableViewNSInteger)titleForFooterInSection;
//- (BOOLTableViewIndexPath)canMoveRowAtIndexPath;
//- (SectionIndexTitlesForTableView)sectionIndexTitlesForTableView;
//- (NSIntegerUITableViewNSStringNSInteger)sectionForSectionIndexTitle;
//- (CGFloatTableViewNSInteger)heightForHeaderInSection;
//- (CGFloatTableViewNSInteger)heightForFooterInSection;
//- (CGFloatTableViewIndexPath)estimatedHeightForRowAtIndexPath;
//- (CGFloatTableViewNSInteger)estimatedHeightForHeaderInSection;
//- (CGFloatTableViewNSInteger)estimatedHeightForFooterInSection;
//- (UIViewTableViewHeaderFooterBlock)viewForHeaderInSection;
//- (UIViewTableViewHeaderFooterBlock)viewForFooterInSection;
//- (NSIndexPathUITableViewNSIndexPath)willSelectRowAtIndexPath;
//- (NSIndexPathUITableViewNSIndexPath)willDeselectRowAtIndexPath;
//- (UITableViewCellEditingStyleUITableViewNSIndexPath)editingStyleForRowAtIndexPath;
//- (NSStringTableViewIndexPath)titleForDeleteConfirmationButtonForRowAtIndexPath;
//- (BOOLTableViewIndexPath)shouldIndentWhileEditingRowAtIndexPath;
//- (NSIndexPathUITableViewNSIndexPathNSIndexPath)targetIndexPathForMoveFromRowAtIndexPath;
//- (NSIntegerUITableViewNSIndexPath)indentationLevelForRowAtIndexPath;
//- (BOOLTableViewIndexPath)shouldShowMenuForRowAtIndexPath;
//- (BOOLUITableViewSELNSIndexPath)canPerformAction;
//- (BOOLTableViewIndexPath)canFocusRowAtIndexPath;
//- (BOOLUITableViewFocusUpdateContext)shouldUpdateFocusInContext;
//- (NSIndexPathUITableView)indexPathForPreferredFocusedViewInTableView;
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
- (UITableView*)setViewForHeaderInSection:(UIViewTableViewHeaderFooterBlock)block;
- (UITableView*)setViewForFooterInSection:(UIViewTableViewHeaderFooterBlock)block;
- (UITableView*)setWillSelectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block;
- (UITableView*)setWillDeselectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block;
- (UITableView*)setEditingStyleForRowAtIndexPath:(UITableViewCellEditingStyleUITableViewNSIndexPath)block;
- (UITableView*)setTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSStringTableViewIndexPath)block;
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

- (RACSignal*)scrollViewDidScrollSignal;
- (RACSignal*)scrollViewWillBeginDraggingSignal;

#pragma DataSource方法
- (RACSignal*)commitEditingStyleSignal;
- (RACSignal*)moveRowAtIndexPathSignal;



@end
