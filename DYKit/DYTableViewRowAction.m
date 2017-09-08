//
//  DYTableViewRowAction.m
//  DYKitDemo
//
//  Created by DuYe on 2017/9/8.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "DYTableViewRowAction.h"

@implementation DYTableViewRowAction

+ (instancetype)rowActionWithStyle:(UITableViewRowActionStyle)style title:(nullable NSString *)title handler:(nullable void (^)(UITableViewRowAction * action, id model , NSIndexPath * indexPath))handler{
    DYTableViewRowAction *tableViewAction = [[DYTableViewRowAction alloc] init];
    tableViewAction.style = style;
    tableViewAction.title = title;
    tableViewAction.handler = handler;
    return tableViewAction;
}

@end
