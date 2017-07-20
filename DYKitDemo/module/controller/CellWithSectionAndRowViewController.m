//
//  CellWithSectionAndRowViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/20.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "CellWithSectionAndRowViewController.h"
#import "DYKit.h"
#import "User.h"
#import "OneTypeCellByNibTableViewCell.h"

@interface CellWithSectionAndRowViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CellWithSectionAndRowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[[[[[self.tableView addReuseIdentifier:DY_DEFAULT_ID indexPathRange:^BOOL(NSIndexPath *indexPath) {
        return !(indexPath.section == 1 && indexPath.row == 0);
    } bindingBlock:^(UITableViewCell *cell, NSString *string, NSIndexPath *indexPath) {
        cell.textLabel.text = string;
    }] addReuseIdentifier:@"OneTypeCellByNibTableViewCell" section:1 row:0 bindingBlock:^(OneTypeCellByNibTableViewCell *cell, User *user, NSIndexPath *indexPath) {
        cell.headImageView.image = [UIImage imageNamed:user.img];
        cell.headImageView.backgroundColor = user.sex == 0 ? [UIColor purpleColor] : [UIColor blackColor];
        cell.nameLabel.text = user.name;
        cell.ageLabel.text = user.age;
        cell.descLabel.text = user.desc;
    }] setNumberOfRowsInSection:^NSInteger(UITableView *tableView, NSInteger section) {
        switch (section) {
            case 0: return 14; break;
            default: return 7; break;
        }
    }] setNumberOfSectionsInTableView:^NSInteger(UITableView *tableView) {
        return 2;
    }] setTitleForHeaderInSection:^NSString *(UITableView *tableView, NSInteger section) {
        return [NSString stringWithFormat:@"这是第%ld个section", (long)section];
    }] setSectionHeaderHeight:50];
    
    
    User *user1 = [User new];
    user1.id = @"001";
    user1.name = @"jack";
    user1.img = @"head";
    user1.age = @"29";
    user1.desc = @"她喜欢黑色";
    user1.sex = 0;
    
    self.tableView.dy_data = @[@"刘德华",@"张学友",@"黎明",@"郭富城",@"郭德纲",@"郭敬明",@"黄晓明",@"柴静",@"宋祖德",@"大S",@"小S",@"欧阳娜娜",@"王力宏",@"周杰伦",user1,@"机器猫",@"大熊",@"(●—●)",@"美少女战士",@"孙悟空",@"贝吉塔"];
    
}

@end
