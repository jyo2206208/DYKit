//
//  CellWithRowViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/20.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "CellWithRowViewController.h"
#import "DYKit.h"

@interface CellWithRowViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CellWithRowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.tableView addReuseIdentifier:@"BlueTableViewCell" FromRow:5 withAssemblyBlock:^(UITableViewCell *cell, NSString *string, NSIndexPath *indexPath) {
        cell.textLabel.text = string;
    }] addReuseIdentifier:DY_DEFAULT_ID FromSlot:^BOOL(NSIndexPath *indexPath, id model) {
        return indexPath.row != 5;
    } withAssemblyBlock:^(UITableViewCell *cell, NSString *string, NSIndexPath *indexPath) {
        cell.textLabel.text = string;
    }];
}

@end
