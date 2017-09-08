//
//  DYTableViewModule.m
//  DYKitDemo
//
//  Created by DuYe on 2017/8/16.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "DYTableViewModule.h"

@implementation DYTableViewModule

- (void)setEditActions:(NSArray<DYTableViewRowAction *> *)editActions{
    _editing = YES;
    _editActions = editActions;
}

@end
