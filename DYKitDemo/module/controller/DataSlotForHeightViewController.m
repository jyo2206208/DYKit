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
    
    [[self.tableView addSlotClass:UITableViewCell.class FromSlot:^BOOL(NSIndexPath *indexPath, NSString *text) {
        return text.length >= 3;;
    } withAssemblyBlock:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    }] setRowHeight:100];
    
    [self.tableView addSlotClass:UITableViewCell.class FromSlot:^BOOL(NSIndexPath *indexPath, NSString *text) {
        return text.length < 3;
    } withAssemblyBlock:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = [text stringByAppendingString:@" 长度不达3的有这段文字"];
        cell.backgroundColor = [UIColor yellowColor];
    }];
    
    RAC(self,tableView.dy_data) = [RACSignal return:@[@"0",@"01",@"012",@"0123",@"01234",@"a",@"bb",@"ccc",@"dddd"]];
}

@end
