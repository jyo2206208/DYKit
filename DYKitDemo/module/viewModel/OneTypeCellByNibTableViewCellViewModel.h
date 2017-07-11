//
//  OneTypeCellByNibTableViewCellViewModel.h
//  DYKitDemo
//
//  Created by DuYe on 2017/7/9.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "DYTableViewCellViewModelProtocol.h"

@interface OneTypeCellByNibTableViewCellViewModel : NSObject<DYTableViewCellViewModelProtocol>

@property (nonatomic, strong) User *user;

@end
