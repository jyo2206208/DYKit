//
//  DataSlotViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/25.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "DataSlotViewController.h"
#import "DYKit.h"

@interface DataSlotViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DataSlotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView assembly:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    }];
    
    [self.tableView assembly:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = [text stringByAppendingString:@" 长度不达3的有这段文字"];
        cell.backgroundColor = [UIColor yellowColor];
    } fromSlot:^BOOL(NSIndexPath *indexPath, NSString *text) {
        return text.length < 3;
    }];
    
    
    RAC(self,tableView.data) = [RACSignal return:@[@"0",@"01",@"012",@"0123",@"01234",@"a",@"bb",@"ccc",@"dddd"]];
    
    
}



@end
