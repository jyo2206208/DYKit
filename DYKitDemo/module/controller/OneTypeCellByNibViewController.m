//
//  OneTypeCellByNibViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/9.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "OneTypeCellByNibViewController.h"
#import "UITableView+DYTableViewBinder.h"
#import "OneTypeCellByNibTableViewCell.h"
#import "OneTypeCellByNibTableViewCellViewModel.h"

@interface OneTypeCellByNibViewController ()
@property (weak, nonatomic) IBOutlet UITableView *oneTypeCellByNibTableView;

@end

@implementation OneTypeCellByNibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpOneTypeCellByNibTableView];
}

- (void)setUpOneTypeCellByNibTableView {
    self.oneTypeCellByNibTableView.rowHeight = 80;
    @weakify(self)
    [self.oneTypeCellByNibTableView bindingForReuseIdentifier:@"OneTypeCellByNibTableViewCell" bindingBlock:^(OneTypeCellByNibTableViewCell *cell, OneTypeCellByNibTableViewCellViewModel *viewModel, NSIndexPath *indexPath) {
        @strongify(self)
        RAC(cell,nameLabel.text) = [RACObserve(viewModel, user.name) takeUntil:cell.rac_prepareForReuseSignal];
        RAC(cell,headImageView.image) = [[RACObserve(viewModel, user.img) takeUntil:cell.rac_prepareForReuseSignal] map:^id _Nullable(NSString *value) {
            return [UIImage imageNamed:value];
        }];
        RAC(cell,ageLabel.text) = [[RACObserve(viewModel, user.age) takeUntil:cell.rac_prepareForReuseSignal] map:^id _Nullable(NSString *value) {
            return [NSString stringWithFormat:@"age:%@",value];
        }];;
        RAC(cell,descLabel.text) = [RACObserve(viewModel, user.desc) takeUntil:cell.rac_prepareForReuseSignal];
    }];
    
    
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
    RAC(self,oneTypeCellByNibTableView.dy_data) = [RACSignal return:@[viewModel1,viewModel2]];
}


@end
