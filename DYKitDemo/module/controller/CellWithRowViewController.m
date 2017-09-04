//
//  CellWithRowViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/20.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "CellWithRowViewController.h"
#import "BlueTableViewCell.h"
#import "DYKit.h"

@interface CellWithRowViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CellWithRowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView assembly:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    }];
    
    [self.tableView assembly:^(BlueTableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    } fromSlot:^BOOL(NSIndexPath *indexPath, id model) {
        //只有row==5的位置才使用BlueTableViewCell
        return indexPath.row == 5;
    } withPlug:BlueTableViewCell.class];
    
    self.tableView.data = @[@"刘德华",@"张学友",@"黎明",@"郭富城",@"郭德纲",@"郭敬明",@"黄晓明",@"柴静",@"宋祖德",@"大S",@"小S",@"欧阳娜娜",@"王力宏",@"周杰伦",@"机器猫",@"大熊",@"(●—●)",@"美少女战士",@"孙悟空",@"贝吉塔"];
}

@end
