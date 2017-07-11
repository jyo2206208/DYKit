//
//  CellWithButtonByNibTableViewCellViewModel.h
//  DYKitDemo
//
//  Created by DuYe on 2017/7/9.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "DYTableViewCellViewModelProtocol.h"

@interface CellWithButtonByNibTableViewCellViewModel : NSObject<DYTableViewCellViewModelProtocol>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) RACCommand *addButtonCommand;

@end
