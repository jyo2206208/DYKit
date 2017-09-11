//
//  SectionsViewController.m
//  DYKitDemo
//
//  Created by farfetch on 2017/9/11.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "SectionsViewController.h"
#import "DYKit.h"

@interface SectionsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView assembly:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    }];
    
    [[self.tableView setTitleForHeaderInSection:^NSString *(UITableView *tableView, NSInteger section) {
        return [NSString stringWithFormat:@"这是第%ld个section", (long)section];
    }] setSectionHeaderHeight:50];
    
    
    
    self.tableView.sectionData = @[@[@"刘德华",@"张学友",@"黎明",@"郭富城",@"郭德纲",@"郭敬明",@"黄晓明",@"柴静",@"宋祖德"],
                                   @[@"大S",@"小S",@"欧阳娜娜",@"王力宏",@"周杰伦"],
                                   @[@"机器猫",@"大熊",@"(●—●)",@"美少女战士",@"孙悟空",@"贝吉塔"]];
}

@end
