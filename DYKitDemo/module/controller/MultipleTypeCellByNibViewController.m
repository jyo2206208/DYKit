//
//  MultipleTypeCellByNibViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/9.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "MultipleTypeCellByNibViewController.h"
#import "UITableView+DYTableViewBinder.h"
#import "CellWithButtonByNibTableViewCell.h"
#import "OneTypeCellByNibTableViewCell.h"
#import "CellWithButtonByNibTableViewCellViewModel.h"
#import "OneTypeCellByNibTableViewCellViewModel.h"

@interface MultipleTypeCellByNibViewController ()
@property (weak, nonatomic) IBOutlet UITableView *multipleTypeCellByNibTableView;

@end

@implementation MultipleTypeCellByNibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpMultipleTypeCellByNibTableView];
}

- (void)setUpMultipleTypeCellByNibTableView {
    self.multipleTypeCellByNibTableView.rowHeight = 80;
    @weakify(self)
    [self.multipleTypeCellByNibTableView bindingForBindingBlock:^(UITableViewCell *cell, id viewModel, NSIndexPath *indexPath) {
        @strongify(self)
        if ([cell isKindOfClass:OneTypeCellByNibTableViewCell.class]) {
            OneTypeCellByNibTableViewCell *customerCell = (OneTypeCellByNibTableViewCell*)cell;
            OneTypeCellByNibTableViewCellViewModel *customerViewModel = (OneTypeCellByNibTableViewCellViewModel*)viewModel;
            RAC(customerCell,nameLabel.text) = [RACObserve(customerViewModel, user.name) takeUntil:cell.rac_prepareForReuseSignal];
            RAC(customerCell,headImageView.image) = [[RACObserve(customerViewModel, user.img) takeUntil:cell.rac_prepareForReuseSignal] map:^id _Nullable(NSString *value) {
                return [UIImage imageNamed:value];
            }];
            RAC(customerCell,ageLabel.text) = [[RACObserve(customerViewModel, user.age) takeUntil:cell.rac_prepareForReuseSignal] map:^id _Nullable(NSString *value) {
                return [NSString stringWithFormat:@"age:%@",value];
            }];;
            RAC(customerCell,descLabel.text) = [RACObserve(customerViewModel, user.desc) takeUntil:cell.rac_prepareForReuseSignal];
        }
        
        if ([cell isKindOfClass:CellWithButtonByNibTableViewCell.class]) {
            CellWithButtonByNibTableViewCell *customerCell = (CellWithButtonByNibTableViewCell*)cell;
            CellWithButtonByNibTableViewCellViewModel *customerViewModel = (CellWithButtonByNibTableViewCellViewModel*)viewModel;
            customerCell.textLabel.text = customerViewModel.title;
            [customerViewModel.addButtonCommand.executionSignals.switchToLatest subscribeNext:^(CellWithButtonByNibTableViewCellViewModel *x) {
                NSMutableArray *newData = [NSMutableArray arrayWithArray:self.multipleTypeCellByNibTableView.dy_data];
                [newData addObject:x];
                self.multipleTypeCellByNibTableView.dy_data = newData;
            }];
            customerCell.addButton.rac_command = customerViewModel.addButtonCommand;
            
        }
        
//    } registerByNib:YES reuseIdentifierArray:@[@"OneTypeCellByNibTableViewCell",@"CellWithButtonByNibTableViewCell"]];
    } reuseIdentifiers:@"OneTypeCellByNibTableViewCell",@"CellWithButtonByNibTableViewCell",nil];
    
    
    
    
    User *user1 = [[User alloc] init];
    user1.name = @"jack";
    user1.img = @"head";
    user1.age = @"12";
    user1.desc = @"Like black";
    OneTypeCellByNibTableViewCellViewModel *viewModel1 = [[OneTypeCellByNibTableViewCellViewModel alloc] init];
    viewModel1.user = user1;
    User *user2 = [[User alloc] init];
    user2.name = @"pinkMan";
    user2.img = @"head";
    user2.age = @"28";
    user2.desc = @"partner of the world's biggest drug dealer";
    OneTypeCellByNibTableViewCellViewModel *viewModel2 = [[OneTypeCellByNibTableViewCellViewModel alloc] init];
    viewModel2.user = user2;
    
    CellWithButtonByNibTableViewCellViewModel *viewModel3 = [[CellWithButtonByNibTableViewCellViewModel alloc] init];
    viewModel3.title = [NSString stringWithFormat:@"%@", [NSDate date]];
    RAC(self,multipleTypeCellByNibTableView.dy_data) = [RACSignal return:@[viewModel1,viewModel2,viewModel3]];
    
    
    
}

@end
