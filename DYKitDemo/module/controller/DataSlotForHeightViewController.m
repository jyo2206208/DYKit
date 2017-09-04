//
//  DataSlotForHeightViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/8/16.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "DataSlotForHeightViewController.h"
#import "DYKit.h"

@interface DataSlotForHeightViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DataSlotForHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *(^dataBlock)() = ^() {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        int count = arc4random() % 30;
        for (int i = 0; i < count; i++) {
            [array addObject:[NSString stringWithFormat:@"%i",arc4random() % 1000]];
        }
        return array;
    };
    
    [self.tableView assembly:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    }];
    
    [[self.tableView assembly:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = [text stringByAppendingString:@" 长度不达3的有这段文字"];
    } fromSlot:^BOOL(NSIndexPath *indexPath, NSString *text) {
        return text.length < 3;
    }] setRowHeight:100];
    
    self.tableView.data = dataBlock();
    
    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc] init];
    reloadItem.title = @"reload";
    reloadItem.tintColor = [UIColor blueColor];
    UIBarButtonItem *autoReloadItem = [[UIBarButtonItem alloc] init];
    autoReloadItem.title = @"autoReload";
    autoReloadItem.tintColor = [UIColor blueColor];
    UIBarButtonItem *newDataItem = [[UIBarButtonItem alloc] init];
    newDataItem.title = @"newData";
    newDataItem.tintColor = [UIColor blueColor];
    
    @weakify(self)
    newDataItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self)
        self.tableView.data = dataBlock();
        return [RACSignal empty];
    }];
    
    autoReloadItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(UIBarButtonItem *input) {
        @strongify(self)
        if ([input.tintColor isEqual:[UIColor lightGrayColor]]) {
            input.tintColor = [UIColor blueColor];
            self.tableView.autoReload = YES;
        } else {
            input.tintColor = [UIColor lightGrayColor];
            self.tableView.autoReload = NO;
        }
        return [RACSignal empty];
    }];
    
    reloadItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self)
        [self.tableView reloadData];
        return [RACSignal empty];
    }];
    self.navigationItem.rightBarButtonItems = @[reloadItem,autoReloadItem,newDataItem];
}

@end
