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
    
    
    [[self.tableView addReuseIdentifier:@"BlueTableViewCell" row:5 bindingBlock:^(UITableViewCell *cell, NSString *string, NSIndexPath *indexPath) {
        cell.textLabel.text = string;
    }] addReuseIdentifier:DY_DEFAULT_ID indexPathRange:^BOOL(NSIndexPath *indexPath) {
        return indexPath.row != 5;
    } bindingBlock:^(UITableViewCell *cell, NSString *string, NSIndexPath *indexPath) {
        cell.textLabel.text = string;
    }];
    
    
    
    
    
    self.tableView.dy_data = @[@"刘德华",@"张学友",@"黎明",@"郭富城",@"郭德纲",@"郭敬明",@"黄晓明",@"柴静",@"宋祖德",@"大S",@"小S",@"欧阳娜娜",@"王力宏",@"周杰伦",@"机器猫",@"大熊",@"(●—●)",@"美少女战士",@"孙悟空",@"贝吉塔"];
}

@end
