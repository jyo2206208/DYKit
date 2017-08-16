//
//  DYTableViewModule.h
//  DYKitDemo
//
//  Created by DuYe on 2017/8/16.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYMacro.h"

#define DY_DEFAULT_ID @"DYTableViewCell"

@interface DYTableViewModule : NSObject

typedef void(^AssemblyBlock)(id cell,id model,NSIndexPath *indexPath);
typedef BOOL(^SlotBlock)(NSIndexPath *indexPath, id model);

@property (nonatomic, copy) NSString *reuseIdentifier;
@property (nonatomic, copy) SlotBlock slotBlock;
@property (nonatomic, copy) AssemblyBlock cellBindBlock;

@property (nonatomic) CGFloat rowHeight;

@end
