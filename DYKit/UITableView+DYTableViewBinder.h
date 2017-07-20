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

@property (nonatomic,strong) DYTableViewAgent *dy_agent;

#pragma getSet
- (id)dy_data;
- (void)setDy_data:(id)dy_data;

- (CGFloatTableViewIndexPath)heightForRowAtIndexPath;
- (EditActionsForRowAtIndexPath)editActionsForRowAtIndexPath;
- (BOOLTableViewIndexPath)shouldHighlightRowAtIndexPath;
- (BOOLTableViewIndexPath)canEditRowAtIndexPath;
- (NSIntegerTableViewIndexPath)numberOfRowsInSection;
//- (UITableViewCellTableViewIndexPath)cellForRowAtIndexPath;
- (NSIntegerUITableView)numberOfSectionsInTableView;
- (NSStringTableViewNSInteger)titleForHeaderInSection;
- (NSStringTableViewNSInteger)titleForFooterInSection;
- (BOOLTableViewIndexPath)canMoveRowAtIndexPath;
- (SectionIndexTitlesForTableView)sectionIndexTitlesForTableView;
- (NSIntegerUITableViewNSStringNSInteger)sectionForSectionIndexTitle;
- (CGFloatTableViewNSInteger)heightForHeaderInSection;
- (CGFloatTableViewNSInteger)heightForFooterInSection;
- (CGFloatTableViewIndexPath)estimatedHeightForRowAtIndexPath;
- (CGFloatTableViewNSInteger)estimatedHeightForHeaderInSection;
- (CGFloatTableViewNSInteger)estimatedHeightForFooterInSection;
- (UIViewTableViewNSInteger)viewForHeaderInSection;
- (UIViewTableViewNSInteger)viewForFooterInSection;
- (NSIndexPathUITableViewNSIndexPath)willSelectRowAtIndexPath;
- (NSIndexPathUITableViewNSIndexPath)willDeselectRowAtIndexPath;
- (UITableViewCellEditingStyleUITableViewNSIndexPath)editingStyleForRowAtIndexPath;
- (NSStringTableViewIndexPath)titleForDeleteConfirmationButtonForRowAtIndexPath;
- (BOOLTableViewIndexPath)shouldIndentWhileEditingRowAtIndexPath;
- (NSIndexPathUITableViewNSIndexPathNSIndexPath)targetIndexPathForMoveFromRowAtIndexPath;
- (NSIntegerUITableViewNSIndexPath)indentationLevelForRowAtIndexPath;
- (BOOLTableViewIndexPath)shouldShowMenuForRowAtIndexPath;
- (BOOLUITableViewSELNSIndexPath)canPerformAction;
- (BOOLTableViewIndexPath)canFocusRowAtIndexPath;
- (BOOLUITableViewFocusUpdateContext)shouldUpdateFocusInContext;
- (NSIndexPathUITableView)indexPathForPreferredFocusedViewInTableView;
- (void)setHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block;
- (void)setEditActionsForRowAtIndexPath:(EditActionsForRowAtIndexPath)block;
- (void)setShouldHighlightRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setCanEditRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setNumberOfRowsInSection:(NSIntegerTableViewIndexPath)block;
//- (void)setCellForRowAtIndexPath:(UITableViewCellTableViewIndexPath)block;
- (void)setNumberOfSectionsInTableView:(NSIntegerUITableView)block;
- (void)setTitleForHeaderInSection:(NSStringTableViewNSInteger)block;
- (void)setTitleForFooterInSection:(NSStringTableViewNSInteger)block;
- (void)setCanMoveRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setSectionIndexTitlesForTableView:(SectionIndexTitlesForTableView)block;
- (void)setSectionForSectionIndexTitle:(NSIntegerUITableViewNSStringNSInteger)block;
- (void)setHeightForHeaderInSection:(CGFloatTableViewNSInteger)block;
- (void)setHeightForFooterInSection:(CGFloatTableViewNSInteger)block;
- (void)setEstimatedHeightForRowAtIndexPath:(CGFloatTableViewIndexPath)block;
- (void)setEstimatedHeightForHeaderInSection:(CGFloatTableViewNSInteger)block;
- (void)setEstimatedHeightForFooterInSection:(CGFloatTableViewNSInteger)block;
- (void)setViewForHeaderInSection:(UIViewTableViewNSInteger)block;
- (void)setViewForFooterInSection:(UIViewTableViewNSInteger)block;
- (void)setWillSelectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block;
- (void)setWillDeselectRowAtIndexPath:(NSIndexPathUITableViewNSIndexPath)block;
- (void)setEditingStyleForRowAtIndexPath:(UITableViewCellEditingStyleUITableViewNSIndexPath)block;
- (void)setTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSStringTableViewIndexPath)block;
- (void)setShouldIndentWhileEditingRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setTargetIndexPathForMoveFromRowAtIndexPath:(NSIndexPathUITableViewNSIndexPathNSIndexPath)block;
- (void)setIndentationLevelForRowAtIndexPath:(NSIntegerUITableViewNSIndexPath)block;
- (void)setShouldShowMenuForRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setCanPerformAction:(BOOLUITableViewSELNSIndexPath)block;
- (void)setCanFocusRowAtIndexPath:(BOOLTableViewIndexPath)block;
- (void)setShouldUpdateFocusInContext:(BOOLUITableViewFocusUpdateContext)block;
- (void)setIndexPathForPreferredFocusedViewInTableView:(NSIndexPathUITableView)block;
#pragma binding

/**
 固定UItableViewCell
 
 @param block cellForRowAtIndexPath的block
 */
- (void) bindingForBindingBlock:(CellBindBlock)block;


//- (void) addReuseIdentifier:(NSString *)identifier bindingBlock:(CellBindBlock)block;

- (UITableView*) addReuseIdentifier:(NSString *)identifier section:(int)section row:(int)row bindingBlock:(CellBindBlock)block;

- (UITableView*) addReuseIdentifier:(NSString *)identifier section:(int)section bindingBlock:(CellBindBlock)block;
- (UITableView*) addReuseIdentifier:(NSString *)identifier row:(int)row bindingBlock:(CellBindBlock)block;


- (UITableView*) addReuseIdentifier:(NSString *)identifier indexPathRange:(IndexPathRangeBlock)indexPathRangeBlock bindingBlock:(CellBindBlock)cellBindBlock;

/**
 固定一种自定义cell
 
 @param block cellForRowAtIndexPath的block
 @param identifier cell的重用ID(使用cell的类名，可以是xib或者class创建)
 */
- (void) bindingForReuseIdentifier:(NSString *)identifier bindingBlock:(CellBindBlock)block;

/**
 多种自定义cell，由nib或class创建
 
 @param block cellForRowAtIndexPath的block
 @param identifiers cell的重用ID的数组(使用cell的类名，可以是xib或者class创建)
 */
//- (void) bindingForReuseIdentifiers:(NSArray *)identifiers bindingBlock:(CellBindBlock)block;

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
