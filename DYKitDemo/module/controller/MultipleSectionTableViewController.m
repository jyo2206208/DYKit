//
//  MultipleSectionTableViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/10.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "MultipleSectionTableViewController.h"
#import "UITableView+DYTableViewBinder.h"

@interface MultipleSectionTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *multipleSectionTableView;

@end

@implementation MultipleSectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.multipleSectionTableView bindingForBindingBlock:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@section = %ld,row = %ld",text,(long)indexPath.section,(long)indexPath.row];
    }];
    
    [self.multipleSectionTableView setNumberOfSectionsInTableView:^NSInteger(UITableView *tableView) {
        return 3;
    }];
    [self.multipleSectionTableView setHeightForHeaderInSection:^CGFloat(UITableView *tableView, NSInteger section) {
        return 50;
    }];
    
    [self.multipleSectionTableView setViewForHeaderInSection:^UIView *(UITableView *tableView, NSInteger section) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
        view.text = @"header";
        view.backgroundColor = [UIColor yellowColor];
        return view;
    }];
    
    RAC(self,multipleSectionTableView.dy_data) = [RACSignal return:@[@"刘德华",@"张学友",@"黎明",@"郭富城",@"金城武",@"郭采洁",@"林志玲",@"小S",@"大S",@"陈坤",@"杨坤",@"杨幂",@"刘恺威",@"王宝强",@"王凯",@"钟欣桐",@"蔡卓妍",@"陈冠希",@"乐嘉",@"汪涵",@"薛之谦",@"柳岩"]];
}

@end
