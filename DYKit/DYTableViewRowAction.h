//
//  DYTableViewRowAction.h
//  DYKitDemo
//
//  Created by DuYe on 2017/9/8.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYTableViewRowAction : NSObject

NS_ASSUME_NONNULL_BEGIN
@property (nonatomic) UITableViewRowActionStyle style;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) void (^ handler)(UITableViewRowAction * action, id model , NSIndexPath * indexPath);

+ (instancetype)rowActionWithStyle:(UITableViewRowActionStyle)style title:(nullable NSString *)title handler:(nullable void (^)(UITableViewRowAction * action, id model , NSIndexPath * indexPath))handler;

NS_ASSUME_NONNULL_END

@end
