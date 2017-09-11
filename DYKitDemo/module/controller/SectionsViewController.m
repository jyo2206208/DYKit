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
    
    [[[self.tableView setSectionData:^NSArray *(NSDictionary *model, NSInteger section) {
        return model[@"data"];
    }] setTitleForHeaderInSection:^NSString *(UITableView *tableView, NSInteger section) {
        return [NSString stringWithFormat:@"这是第%ld个section", (long)section];
    }] setSectionHeaderHeight:30];
    
    
    
    self.tableView.data = @[@{@"name":@"港台明星",@"data":@[@"刘德华",@"张学友",@"黎明",@"郭富城",@"蔡康永"]},
                                   @{@"name":@"大陆明星",@"data":@[@"薛之谦",@"杨幂",@"王宝强",@"黄渤"]},
                                   @{@"name":@"动漫明星",@"data":@[@"机器猫",@"大熊",@"(●—●)",@"美少女战士",@"孙悟空",@"贝吉塔"]},
                                   ];
}

@end
