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
#import "DataSlotForHeightViewController.h"
#import "EditActionsViewController.h"
#import "SectionsViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self homeTableViewSetUp];
}


- (void)homeTableViewSetUp {
    
    [self.homeTableView assembly:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        //这个block充当了cellForRowAtIndexPath的作用
        cell.textLabel.text = text;
    }];
    
    self.homeTableView.data = @[@"固定一种自定义cell",
                                   @"指定section和row(或具体indexPath)设定cell",
                                   @"指定section进行cell设定",
                                   @"指定row进行cell设定",
                                   @"指定数据条件进行cell设定",
                                   @"指定模块进行高度设定",
                                   @"左滑出现按钮",
                                @"多section的情况"];
    
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
    
    [[[self.homeTableView.didSelectRowAtIndexPathSignal reduceEach:^id (UITableView *tableView ,NSIndexPath *indexPath){
        return @(indexPath.row);
    }] filter:^BOOL(id  _Nullable value) {
        return [value intValue] == 5;
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[[DataSlotForHeightViewController alloc] init] animated:YES];
    }];
    
    [[[self.homeTableView.didSelectRowAtIndexPathSignal reduceEach:^id (UITableView *tableView ,NSIndexPath *indexPath){
        return @(indexPath.row);
    }] filter:^BOOL(id  _Nullable value) {
        return [value intValue] == 6;
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[[EditActionsViewController alloc] init] animated:YES];
    }];
    
    [[[self.homeTableView.didSelectRowAtIndexPathSignal reduceEach:^id (UITableView *tableView ,NSIndexPath *indexPath){
        return @(indexPath.row);
    }] filter:^BOOL(id  _Nullable value) {
        return [value intValue] == 7;
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[[SectionsViewController alloc] init] animated:YES];
    }];
    
}
@end
