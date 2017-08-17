//
//  CellWithSectionViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/20.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "CellWithSectionViewController.h"
#import "DYKit.h"
#import "User.h"
#import "OneTypeCellByNibTableViewCell.h"
#import "BlueTableViewCell.h"

@interface CellWithSectionViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CellWithSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView assembly:^(UITableViewCell *cell, NSString *string, NSIndexPath *indexPath) {
        cell.textLabel.text = string;
    } fromSlot:^BOOL(NSIndexPath *indexPath, id model) {
        return indexPath.section == 0;
    }];
    
    [self.tableView assembly:^(OneTypeCellByNibTableViewCell *cell, User *user, NSIndexPath *indexPath) {
        cell.headImageView.image = [UIImage imageNamed:user.img];
        cell.headImageView.backgroundColor = user.sex == 0 ? [UIColor purpleColor] : [UIColor blackColor];
        cell.nameLabel.text = user.name;
        cell.ageLabel.text = user.age;
        cell.descLabel.text = user.desc;
    } fromSlot:^BOOL(NSIndexPath *indexPath, id model) {
        return indexPath.section == 1;
    } withPlug:OneTypeCellByNibTableViewCell.class];
    
    [self.tableView assembly:^(UITableViewCell *cell, NSString *text, NSIndexPath *indexPath) {
        cell.textLabel.text = text;
    } fromSlot:^BOOL(NSIndexPath *indexPath, id model) {
        return indexPath.section == 2;
    } withPlug:BlueTableViewCell.class];
    
    
    [[[[[self.tableView setNumberOfRowsInSection:^NSInteger(UITableView *tableView, NSInteger section) {
        switch (section) {
            case 0: return 14; break;
            case 1: return 3; break;
            case 2: return 6; break;
            default: return 0; break;
        }
    }] setNumberOfSectionsInTableView:^NSInteger(UITableView *tableView) {
        return 3;
    }] setTitleForHeaderInSection:^NSString *(UITableView *tableView, NSInteger section) {
        return [NSString stringWithFormat:@"这是第%ld个section", (long)section];
    }] setHeightForRowAtIndexPath:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return indexPath.row == 1 ? 100 : tableView.rowHeight;
    }] setSectionHeaderHeight:50];
    
    
    User *user1 = [User new];
    User *user2 = [User new];
    User *user3 = [User new];
    user1.id = @"001";
    user1.name = @"jack";
    user1.img = @"head";
    user1.age = @"29";
    user1.desc = @"她喜欢黑色";
    user1.sex = 0;
    user2.id = @"002";
    user2.name = @"Pink man";
    user2.img = @"head";
    user2.age = @"18";
    user2.desc = @"白老师得意门生";
    user2.sex = 1;
    user3.id = @"003";
    user3.name = @"MR.white";
    user3.img = @"head";
    user3.age = @"43";
    user3.desc = @"平淡无奇的中学化学老师";
    user3.sex = 1;
    
    self.tableView.dy_data = @[@"刘德华",@"张学友",@"黎明",@"郭富城",@"郭德纲",@"郭敬明",@"黄晓明",@"柴静",@"宋祖德",@"大S",@"小S",@"欧阳娜娜",@"王力宏",@"周杰伦",user1,user2,user3,@"机器猫",@"大熊",@"(●—●)",@"美少女战士",@"孙悟空",@"贝吉塔"];
    
}

@end
