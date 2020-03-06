//
//  ViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/8.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "ViewController.h"
#import "DYKit.h"
#import "OneTypeCellViewController.h"
#import "CellWithSectionAndRowViewController.h"
#import "CellWithSectionViewController.h"
#import "CellWithRowViewController.h"
#import "DataSlotViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self homeTableViewSetUp];
}


- (void)homeTableViewSetUp {
    
    [self.homeTableView assemblyWithAssemblyBlock:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        //这个block充当了cellForRowAtIndexPath的作用
        cell.textLabel.text = text;
    }];
    
    NSArray *dy_data = @[@"固定一种自定义cell",
                                   @"指定section和row(或具体indexPath)设定cell",
                                   @"指定section进行cell设定",
                                   @"指定row进行cell设定",
                                   @"指定数据条件进行cell设定"];
    
    self.homeTableView.modelOfCellAtIndexPath = ^id(NSIndexPath *indexPath) {
        NSInteger index = indexPath.row;
        return dy_data[index];
    };
    
    [self.homeTableView setNumberOfRowsInSection:^NSInteger(UITableView *tableView, NSInteger section) {
        return dy_data.count;
    }];
    
    @weakify(self)
    [[[self.homeTableView.didSelectRowAtIndexPathSignal reduceEach:^id (UITableView *tableView ,NSIndexPath *indexPath){
        return @(indexPath.row);
    }] filter:^BOOL(id  _Nullable value) {
        return [value intValue] == 0;
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[[OneTypeCellViewController alloc] init] animated:YES];
    }];
    
    [[[self.homeTableView.didSelectRowAtIndexPathSignal reduceEach:^id (UITableView *tableView ,NSIndexPath *indexPath){
        return @(indexPath.row);
    }] filter:^BOOL(id  _Nullable value) {
        return [value intValue] == 1;
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[[CellWithSectionAndRowViewController alloc] init] animated:YES];
    }];
    
    [[[self.homeTableView.didSelectRowAtIndexPathSignal reduceEach:^id (UITableView *tableView ,NSIndexPath *indexPath){
        return @(indexPath.row);
    }] filter:^BOOL(id  _Nullable value) {
        return [value intValue] == 2;
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[[CellWithSectionViewController alloc] init] animated:YES];
    }];
    
    [[[self.homeTableView.didSelectRowAtIndexPathSignal reduceEach:^id (UITableView *tableView ,NSIndexPath *indexPath){
        return @(indexPath.row);
    }] filter:^BOOL(id  _Nullable value) {
        return [value intValue] == 3;
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[[CellWithRowViewController alloc] init] animated:YES];
    }];
    
    [[[self.homeTableView.didSelectRowAtIndexPathSignal reduceEach:^id (UITableView *tableView ,NSIndexPath *indexPath){
        return @(indexPath.row);
    }] filter:^BOOL(id  _Nullable value) {
        return [value intValue] == 4;
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[[DataSlotViewController alloc] init] animated:YES];
    }];
    
    RAC(self.homeTableView, reload) = [RACSignal return:[NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]];
//    RAC(self.homeTableView, reload) = [RACSignal interval:5 onScheduler:RACScheduler.mainThreadScheduler];
    
}
@end
