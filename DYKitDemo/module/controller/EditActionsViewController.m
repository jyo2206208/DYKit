//
//  EditActionsViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/9/6.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "EditActionsViewController.h"
#import "DYKit.h"

@interface EditActionsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EditActionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableViewRowAction *firstAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"第一" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"第一个按钮被点击了");
    }];
    UITableViewRowAction *secondAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"第二" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"第二个按钮被点击了");
    }];
    
    [[self.tableView assembly:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    } fromSlot:^BOOL(NSIndexPath *indexPath, NSString *text) {
        return text.length < 3;
    }] setEditActions:@[firstAction]];
    
    [[self.tableView assembly:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    } fromSlot:^BOOL(NSIndexPath *indexPath, NSString *text) {
        return text.length >= 3;
    }] setEditActions:@[firstAction,secondAction]];
    
    
    NSArray *(^dataBlock)() = ^() {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        int count = arc4random() % 30;
        for (int i = 0; i < count; i++) {
            [array addObject:[NSString stringWithFormat:@"%i",arc4random() % 1000]];
        }
        return array;
    };
    
    self.tableView.data = dataBlock();
}

@end
