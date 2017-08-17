//
//  OneTypeCellViewController.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/20.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "OneTypeCellViewController.h"
#import "DYKit.h"
#import "User.h"
#import "OneTypeCellByNibTableViewCell.h"

@interface OneTypeCellViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OneTypeCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView assembly:^(OneTypeCellByNibTableViewCell *cell, User *user, NSIndexPath *indexPath) {
        cell.headImageView.image = [UIImage imageNamed:user.img];
        cell.headImageView.backgroundColor = user.sex == 0 ? [UIColor purpleColor] : [UIColor blackColor];
        cell.nameLabel.text = user.name;
        cell.ageLabel.text = user.age;
        cell.descLabel.text = user.desc;
    } withPlug:OneTypeCellByNibTableViewCell.class];
    
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
    
    self.tableView.dy_data = @[user1,user2,user3];
}

@end
