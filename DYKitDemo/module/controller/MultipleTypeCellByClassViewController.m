//
//  MultipleTypeCellByClassViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/9.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "MultipleTypeCellByClassViewController.h"
#import "UITableView+DYTableViewBinder.h"
#import "OneTypeCellByClassTableViewCell.h"
#import "BlueTableViewCell.h"
#import "OneTypeCellByClassTableViewCellViewModel.h"
#import "BlueTableViewCellViewModel.h"

@interface MultipleTypeCellByClassViewController ()
@property (weak, nonatomic) IBOutlet UITableView *multipleTypeCellByClassTableView;

@end

@implementation MultipleTypeCellByClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpMultipleTypeCellByClassTableView];
}

- (void)setUpMultipleTypeCellByClassTableView {
    [self.multipleTypeCellByClassTableView bindingForBindingBlock:^(UITableViewCell *cell, id viewModel, NSIndexPath *indexPath) {
        if ([cell isKindOfClass:OneTypeCellByClassTableViewCell.class]) {
            OneTypeCellByClassTableViewCellViewModel *customerViewModel = (OneTypeCellByClassTableViewCellViewModel*)viewModel;
            cell.textLabel.text = customerViewModel.title;
        } else if ([cell isKindOfClass:BlueTableViewCell.class]) {
            BlueTableViewCellViewModel *tableViewCellViewModel = (BlueTableViewCellViewModel*)viewModel;
            cell.textLabel.text = tableViewCellViewModel.title;
        }
//    } reuseIdentifierArray:@[@"OneTypeCellByClassTableViewCell",@"BlueTableViewCell"]];
        } reuseIdentifiers:@"OneTypeCellByClassTableViewCell",@"BlueTableViewCell",nil];
    
    
    BlueTableViewCellViewModel *tableViewCellViewModel = [[BlueTableViewCellViewModel alloc] init];
    tableViewCellViewModel.title = @"刘德华";
    
    OneTypeCellByClassTableViewCellViewModel *oneTypeCellByClassTableViewCellViewModel = [[OneTypeCellByClassTableViewCellViewModel alloc] init];
    oneTypeCellByClassTableViewCellViewModel.title = @"王宝强";
    
    RAC(self,multipleTypeCellByClassTableView.dy_data) = [RACSignal return:@[tableViewCellViewModel,oneTypeCellByClassTableViewCellViewModel]];
    
    
    
    
}

@end
