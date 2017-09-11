//
//  DYTableViewDataSouce.h
//  DYMVVMRAC
//
//  Created by DuYe on 2017/7/7.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYTableViewModule.h"

#if __has_include("ReactiveCocoa.h")
#import "ReactiveCocoa.h"
#else
#import <ReactiveObjC/ReactiveObjC.h>
#endif

@interface DYTableViewAgent : NSObject <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSArray *data;
@property (nonatomic, strong) NSMutableArray<DYTableViewModule*> *tableModuleLists;
@property (nonatomic, strong) DYTableViewModule *defaultTableModule;

typedef NSArray* (^GetSectionData)(id model,NSInteger section);
@property (nonatomic, copy) GetSectionData getSectionData;


#pragma 下面是自带的配置
typedef CGFloat (^CGFloatTableViewIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) CGFloatTableViewIndexPath heightForRowAtIndexPath;
@property (nonatomic, copy) CGFloatTableViewIndexPath estimatedHeightForRowAtIndexPath;

typedef CGFloat (^CGFloatTableViewNSInteger)(UITableView *tableView,NSInteger section);
@property (nonatomic, copy) CGFloatTableViewNSInteger heightForHeaderInSection;
@property (nonatomic, copy) CGFloatTableViewNSInteger heightForFooterInSection;
@property (nonatomic, copy) CGFloatTableViewNSInteger estimatedHeightForHeaderInSection;
@property (nonatomic, copy) CGFloatTableViewNSInteger estimatedHeightForFooterInSection;

typedef NSArray<UITableViewRowAction *> *(^EditActionsForRowAtIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) EditActionsForRowAtIndexPath editActionsForRowAtIndexPath;

typedef BOOL (^BOOLTableViewIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) BOOLTableViewIndexPath shouldHighlightRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath canEditRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath shouldIndentWhileEditingRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath shouldShowMenuForRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath canFocusRowAtIndexPath;

typedef NSInteger (^NSIntegerTableViewIndexPath)(UITableView *tableView,NSInteger section);
@property (nonatomic, copy) NSIntegerTableViewIndexPath numberOfRowsInSection;

//typedef UITableViewCell *(^UITableViewCellTableViewIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
//@property (nonatomic, copy) UITableViewCellTableViewIndexPath cellForRowAtIndexPath;

typedef NSInteger (^NSIntegerUITableView)(UITableView *tableView);
@property (nonatomic, copy) NSIntegerUITableView numberOfSectionsInTableView;

typedef NSString *(^NSStringTableViewNSInteger)(UITableView *tableView,NSInteger section);
@property (nonatomic, copy) NSStringTableViewNSInteger titleForHeaderInSection;
@property (nonatomic, copy) NSStringTableViewNSInteger titleForFooterInSection;


@property (nonatomic, copy) BOOLTableViewIndexPath canMoveRowAtIndexPath;

typedef NSArray<NSString *> *(^SectionIndexTitlesForTableView)(UITableView *tableView);
@property (nonatomic, copy) SectionIndexTitlesForTableView sectionIndexTitlesForTableView;

typedef NSInteger (^NSIntegerUITableViewNSStringNSInteger)(UITableView *tableView,NSString *title,NSInteger index);
@property (nonatomic, copy) NSIntegerUITableViewNSStringNSInteger sectionForSectionIndexTitle;

typedef UIView *(^UIViewTableViewNSInteger)(UITableView *tableView,NSInteger section);
@property (nonatomic, copy) UIViewTableViewNSInteger viewForHeaderInSection;
@property (nonatomic, copy) UIViewTableViewNSInteger viewForFooterInSection;

typedef NSIndexPath *(^NSIndexPathUITableViewNSIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) NSIndexPathUITableViewNSIndexPath willSelectRowAtIndexPath;
@property (nonatomic, copy) NSIndexPathUITableViewNSIndexPath willDeselectRowAtIndexPath;

typedef UITableViewCellEditingStyle (^UITableViewCellEditingStyleUITableViewNSIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) UITableViewCellEditingStyleUITableViewNSIndexPath editingStyleForRowAtIndexPath;

typedef NSString *(^NSStringTableViewIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) NSStringTableViewIndexPath titleForDeleteConfirmationButtonForRowAtIndexPath;


typedef NSIndexPath *(^NSIndexPathUITableViewNSIndexPathNSIndexPath)(UITableView *tableView,NSIndexPath *sourceIndexPath,NSIndexPath *proposedDestinationIndexPath);
@property (nonatomic, copy) NSIndexPathUITableViewNSIndexPathNSIndexPath targetIndexPathForMoveFromRowAtIndexPath;

typedef NSInteger (^NSIntegerUITableViewNSIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) NSIntegerUITableViewNSIndexPath indentationLevelForRowAtIndexPath;

typedef BOOL (^BOOLUITableViewSELNSIndexPath)(UITableView *tableView,SEL action,NSIndexPath *indexPath);
@property (nonatomic, copy) BOOLUITableViewSELNSIndexPath canPerformAction;

typedef BOOL (^BOOLUITableViewFocusUpdateContext)(UITableView *tableView,UITableViewFocusUpdateContext *context);
@property (nonatomic, copy) BOOLUITableViewFocusUpdateContext shouldUpdateFocusInContext;

typedef NSIndexPath *(^NSIndexPathUITableView)(UITableView *tableView);
@property (nonatomic, copy) NSIndexPathUITableView indexPathForPreferredFocusedViewInTableView;

@end


