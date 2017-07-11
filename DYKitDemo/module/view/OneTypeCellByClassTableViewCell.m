//
//  OneTypeCellByClassTableViewCell.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/9.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "OneTypeCellByClassTableViewCell.h"

@implementation OneTypeCellByClassTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

@end
