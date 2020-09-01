//
//  DYTableViewDataSouce.h
//  DYMVVMRAC
//
//  Created by DuYe on 2017/7/7.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __has_include("ReactiveCocoa.h")
#import "ReactiveCocoa.h"
#else
#import <ReactiveObjC/ReactiveObjC.h>
#endif

#define DY_DEFAULT_ID @"DYTableViewCell"

#ifndef DYSYNTH_DYNAMIC_PROPERTY_OBJECT
#define DYSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_ *)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_ *)_getter_ { \
_type_ * _obj = objc_getAssociatedObject(self, @selector(_setter_:)); \
if (!_obj) { \
    _obj = [NSClassFromString(@#_type_) new];\
} \
return  _obj;\
}
#endif

@interface CellInfo : NSObject

typedef void(^AssemblyBlock)(id _Nonnull cell,id _Nullable model,NSIndexPath * _Nonnull indexPath);
typedef BOOL(^SlotBlock)(NSIndexPath * _Nonnull indexPath, id _Nullable model);

@property (nonatomic, copy) NSString * _Nonnull reuseIdentifier;
@property (nonatomic, copy) SlotBlock _Nullable slotBlock;
@property (nonatomic, copy) AssemblyBlock _Nonnull cellBindBlock;

@end

@interface DYTableViewAgent : NSObject <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) id _Nonnull reload;

@property (nonatomic, strong, nonnull) id _Nullable (^modelOfCellAtIndexPath)(NSIndexPath * _Nonnull indexPath);
@property (nonatomic, strong) id _Nullable (^ _Nullable modelOfHeaderAtSection)(NSInteger section);
@property (nonatomic, strong) id _Nullable (^ _Nullable modelOfFooterAtSection)(NSInteger section);

@property (nonatomic, copy) AssemblyBlock _Nullable cellBindBlock;
@property (nonatomic, strong) NSMutableArray<CellInfo*> * _Nullable cellInfoList;


typedef CGFloat (^CGFloatTableViewIndexPath)(UITableView * _Nonnull tableView,NSIndexPath * _Nonnull indexPath);
@property (nonatomic, copy) CGFloatTableViewIndexPath _Nullable heightForRowAtIndexPath;
@property (nonatomic, copy) CGFloatTableViewIndexPath _Nullable estimatedHeightForRowAtIndexPath;

typedef CGFloat (^CGFloatTableViewNSInteger)(UITableView * _Nonnull tableView,NSInteger section);
@property (nonatomic, copy) CGFloatTableViewNSInteger _Nullable heightForHeaderInSection;
@property (nonatomic, copy) CGFloatTableViewNSInteger _Nullable heightForFooterInSection;
@property (nonatomic, copy) CGFloatTableViewNSInteger _Nullable estimatedHeightForHeaderInSection;
@property (nonatomic, copy) CGFloatTableViewNSInteger _Nullable estimatedHeightForFooterInSection;

typedef NSArray<UITableViewRowAction *> *_Nonnull(^EditActionsForRowAtIndexPath)(UITableView * _Nonnull tableView,NSIndexPath * _Nonnull indexPath);
@property (nonatomic, copy) EditActionsForRowAtIndexPath _Nullable editActionsForRowAtIndexPath;

typedef BOOL (^BOOLTableViewIndexPath)(UITableView * _Nonnull tableView,NSIndexPath * _Nonnull indexPath);
@property (nonatomic, copy) BOOLTableViewIndexPath _Nullable shouldHighlightRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath _Nullable canEditRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath _Nullable shouldIndentWhileEditingRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath _Nullable shouldShowMenuForRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath _Nullable canFocusRowAtIndexPath;

typedef NSInteger (^NSIntegerTableViewIndexPath)(UITableView * _Nonnull tableView,NSInteger section);
@property (nonatomic, copy) NSIntegerTableViewIndexPath _Nonnull numberOfRowsInSection;

//typedef UITableViewCell *(^UITableViewCellTableViewIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
//@property (nonatomic, copy) UITableViewCellTableViewIndexPath cellForRowAtIndexPath;

typedef NSInteger (^NSIntegerUITableView)(UITableView * _Nonnull tableView);
@property (nonatomic, copy) NSIntegerUITableView _Nonnull numberOfSectionsInTableView;

typedef NSString *_Nonnull(^NSStringTableViewNSInteger)(UITableView * _Nonnull tableView,NSInteger section);
@property (nonatomic, copy) NSStringTableViewNSInteger _Nullable titleForHeaderInSection;
@property (nonatomic, copy) NSStringTableViewNSInteger _Nullable titleForFooterInSection;


@property (nonatomic, copy) BOOLTableViewIndexPath _Nonnull canMoveRowAtIndexPath;

typedef NSArray<NSString *> *_Nullable(^SectionIndexTitlesForTableView)(UITableView * _Nonnull tableView);
@property (nonatomic, copy) SectionIndexTitlesForTableView _Nonnull sectionIndexTitlesForTableView;

typedef NSInteger (^NSIntegerUITableViewNSStringNSInteger)(UITableView * _Nonnull tableView,NSString * _Nullable title,NSInteger index);
@property (nonatomic, copy) NSIntegerUITableViewNSStringNSInteger _Nonnull sectionForSectionIndexTitle;

typedef UIView *_Nullable(^UIViewTableViewHeaderFooterBlock)(UITableView * _Nonnull tableView,NSInteger section,id _Nullable model);
@property (nonatomic, copy) UIViewTableViewHeaderFooterBlock _Nullable viewForHeaderInSection;
@property (nonatomic, copy) UIViewTableViewHeaderFooterBlock _Nullable viewForFooterInSection;

typedef NSIndexPath *_Nonnull(^NSIndexPathUITableViewNSIndexPath)(UITableView * _Nonnull tableView,NSIndexPath * _Nonnull indexPath);
@property (nonatomic, copy) NSIndexPathUITableViewNSIndexPath _Nullable willSelectRowAtIndexPath;
@property (nonatomic, copy) NSIndexPathUITableViewNSIndexPath _Nullable willDeselectRowAtIndexPath;

typedef UITableViewCellEditingStyle (^UITableViewCellEditingStyleUITableViewNSIndexPath)(UITableView * _Nonnull tableView,NSIndexPath * _Nonnull indexPath);
@property (nonatomic, copy) UITableViewCellEditingStyleUITableViewNSIndexPath _Nullable editingStyleForRowAtIndexPath;

typedef NSString *_Nonnull(^NSStringTableViewIndexPath)(UITableView * _Nonnull tableView,NSIndexPath * _Nonnull indexPath);
@property (nonatomic, copy) NSStringTableViewIndexPath _Nullable titleForDeleteConfirmationButtonForRowAtIndexPath;


typedef NSIndexPath *_Nonnull(^NSIndexPathUITableViewNSIndexPathNSIndexPath)(UITableView * _Nonnull tableView,NSIndexPath * _Nonnull sourceIndexPath,NSIndexPath * _Nonnull proposedDestinationIndexPath);
@property (nonatomic, copy) NSIndexPathUITableViewNSIndexPathNSIndexPath _Nullable targetIndexPathForMoveFromRowAtIndexPath;

typedef NSInteger (^NSIntegerUITableViewNSIndexPath)(UITableView * _Nonnull tableView,NSIndexPath * _Nonnull indexPath);
@property (nonatomic, copy) NSIntegerUITableViewNSIndexPath _Nullable indentationLevelForRowAtIndexPath;

typedef BOOL (^BOOLUITableViewSELNSIndexPath)(UITableView * _Nonnull tableView,SEL _Nonnull action,NSIndexPath * _Nonnull indexPath);
@property (nonatomic, copy) BOOLUITableViewSELNSIndexPath _Nullable canPerformAction;

typedef BOOL (^BOOLUITableViewFocusUpdateContext)(UITableView * _Nonnull tableView,UITableViewFocusUpdateContext * _Nullable context);
@property (nonatomic, copy) BOOLUITableViewFocusUpdateContext _Nullable shouldUpdateFocusInContext;

typedef NSIndexPath *_Nonnull(^NSIndexPathUITableView)(UITableView * _Nonnull tableView);
@property (nonatomic, copy) NSIndexPathUITableView _Nullable indexPathForPreferredFocusedViewInTableView;

@end


