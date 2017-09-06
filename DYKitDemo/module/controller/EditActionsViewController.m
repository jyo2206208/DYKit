//
//  EditActionsViewController.m
//  DYKitDemo
//
//  Created by farfetch on 2017/9/6.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "EditActionsViewController.h"
#import "DYKit.h"

@interface EditActionsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EditActionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView assembly:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    }];
    
    
    self.tableView.data = @[@"左滑一个",@"左滑三个"];
}

@end
