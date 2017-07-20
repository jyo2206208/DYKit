//
//  ViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/8.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "ViewController.h"
#import "DYKit.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self homeTableViewSetUp];
}


- (void)homeTableViewSetUp {
    
    [self.homeTableView bindingForBindingBlock:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    }];
    
    RAC(self,homeTableView.dy_data) = [RACSignal return:@[@"固定一种自定义cell",
                                                          @"指定section和row进行cell设定",
                                                          @"指定row进行cell设定",
                                                          @"指定具体的indexPath进行cell设定"
                                                          ]];
    
//    [[self.homeTableView.didSelectRowAtIndexPathSignal filter:^BOOL(RACTuple *tuple) {
//        NSIndexPath *indexPath = tuple.second;
//        return indexPath.row == 0;
//    }] subscribeNext:^(RACTuple *tuple) {
//        [self.navigationController pushViewController:[[OneTypeCellByNibViewController alloc] init] animated:YES];
//    }];
//    
//    [[self.homeTableView.didSelectRowAtIndexPathSignal filter:^BOOL(RACTuple *tuple) {
//        NSIndexPath *indexPath = tuple.second;
//        return indexPath.row == 1;
//    }] subscribeNext:^(RACTuple *tuple) {
//        [self.navigationController pushViewController:[[OneTypeCellByClassTableViewController alloc] init] animated:YES];
//    }];
//    
//    [[self.homeTableView.didSelectRowAtIndexPathSignal filter:^BOOL(RACTuple *tuple) {
//        NSIndexPath *indexPath = tuple.second;
//        return indexPath.row == 2;
//    }] subscribeNext:^(RACTuple *tuple) {
//        [self.navigationController pushViewController:[[MultipleTypeCellByNibViewController alloc] init] animated:YES];
//    }];
//    
//    [[self.homeTableView.didSelectRowAtIndexPathSignal filter:^BOOL(RACTuple *tuple) {
//        NSIndexPath *indexPath = tuple.second;
//        return indexPath.row == 3;
//    }] subscribeNext:^(RACTuple *tuple) {
//        [self.navigationController pushViewController:[[MultipleTypeCellByClassViewController alloc] init] animated:YES];
//    }];
//    
//    [[self.homeTableView.didSelectRowAtIndexPathSignal filter:^BOOL(RACTuple *tuple) {
//        NSIndexPath *indexPath = tuple.second;
//        return indexPath.row == 4;
//    }] subscribeNext:^(RACTuple *tuple) {
//        [self.navigationController pushViewController:[[MultipleSectionTableViewController alloc] init] animated:YES];
//    }];
    
    
}

@end
