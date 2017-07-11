//
//  ViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/8.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "ViewController.h"
#import "DYKit.h"
#import "OneTypeCellByNibViewController.h"
#import "OneTypeCellByClassTableViewController.h"
#import "MultipleTypeCellByNibViewController.h"
#import "MultipleTypeCellByClassViewController.h"
#import "MultipleSectionTableViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self homeTableViewSetUp];
}


- (void)homeTableViewSetUp {
    
    [self.homeTableView bindingForBindingBlock:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    }];
    
    self.homeTableView.heightForRowAtIndexPath = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return indexPath.row == 0 ? 150:tableView.rowHeight;
    };
    
    self.homeTableView.editActionsForRowAtIndexPath = ^NSArray<UITableViewRowAction *> *(UITableView *tableView, NSIndexPath *indexPath) {
//        return nil;
        UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"action1" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"do someThing by action1");
        }];
        action1.backgroundColor = [UIColor lightGrayColor];
        
        UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"action2" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"do someThing by action2");
        }];
        return @[action1,action2];
    };
    [self.homeTableView setCanEditRowAtIndexPath:^BOOL(UITableView *tableView, NSIndexPath *indexPath) {
        return YES;
    }];
//    self.homeTableView.editing = YES;
    
//    self.homeTableView.shouldHighlightRowAtIndexPath = ^BOOL(UITableView *tableView, NSIndexPath *indexPath) {
//        return indexPath.row == 1?NO:YES;
//    };
    
    
    
    RAC(self,homeTableView.dy_data) = [RACSignal return:@[@"固定一种自定义cell，由nib创建",
                                                          @"固定一种自定义cell，由class创建",
                                                          @"多种自定义cell，由nib创建",
                                                          @"多种自定义cell，由class创建",
                                                          @"带多个section的表"]];
    
    [[self.homeTableView.didSelectRowAtIndexPathSignal filter:^BOOL(RACTuple *tuple) {
        NSIndexPath *indexPath = tuple.second;
        return indexPath.row == 0;
    }] subscribeNext:^(RACTuple *tuple) {
        [self.navigationController pushViewController:[[OneTypeCellByNibViewController alloc] init] animated:YES];
    }];
    
    [[self.homeTableView.didSelectRowAtIndexPathSignal filter:^BOOL(RACTuple *tuple) {
        NSIndexPath *indexPath = tuple.second;
        return indexPath.row == 1;
    }] subscribeNext:^(RACTuple *tuple) {
        [self.navigationController pushViewController:[[OneTypeCellByClassTableViewController alloc] init] animated:YES];
    }];
    
    [[self.homeTableView.didSelectRowAtIndexPathSignal filter:^BOOL(RACTuple *tuple) {
        NSIndexPath *indexPath = tuple.second;
        return indexPath.row == 2;
    }] subscribeNext:^(RACTuple *tuple) {
        [self.navigationController pushViewController:[[MultipleTypeCellByNibViewController alloc] init] animated:YES];
    }];
    
    [[self.homeTableView.didSelectRowAtIndexPathSignal filter:^BOOL(RACTuple *tuple) {
        NSIndexPath *indexPath = tuple.second;
        return indexPath.row == 3;
    }] subscribeNext:^(RACTuple *tuple) {
        [self.navigationController pushViewController:[[MultipleTypeCellByClassViewController alloc] init] animated:YES];
    }];
    
    [[self.homeTableView.didSelectRowAtIndexPathSignal filter:^BOOL(RACTuple *tuple) {
        NSIndexPath *indexPath = tuple.second;
        return indexPath.row == 4;
    }] subscribeNext:^(RACTuple *tuple) {
        [self.navigationController pushViewController:[[MultipleSectionTableViewController alloc] init] animated:YES];
    }];
    
    
}

@end
