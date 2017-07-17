//
//  OneTypeCellByClassTableViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/9.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "OneTypeCellByClassTableViewController.h"
#import "UITableView+DYTableViewBinder.h"
#import "OneTypeCellByClassTableViewCell.h"

@interface OneTypeCellByClassTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *oneTypeCellByClassTableView;

@end

@implementation OneTypeCellByClassTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpOneTypeCellByClassTableView];
}

- (void)setUpOneTypeCellByClassTableView {
    
    [self.oneTypeCellByClassTableView bindingForReuseIdentifier:@"OneTypeCellByClassTableViewCell" bindingBlock:^(OneTypeCellByClassTableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    }];
    
    RAC(self,oneTypeCellByClassTableView.dy_data) = [RACSignal return:@[@"刘德华",@"张学友",@"黎明",@"郭富城",@"金城武",@"郭采洁",@"林志玲",@"小S",@"大S",@"陈坤",@"杨坤",@"杨幂",@"刘恺威",@"王宝强",@"王凯",@"钟欣桐",@"蔡卓妍",@"陈冠希",@"乐嘉",@"汪涵",@"薛之谦",@"柳岩"]];
}

@end
