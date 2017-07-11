//
//  CellWithButtonByNibTableViewCellViewModel.m
//  DYKitDemo
//
//  Created by DuYe on 2017/7/9.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "CellWithButtonByNibTableViewCellViewModel.h"

#define DY_LAZY(object, assignment) (object = object ?: assignment)

@implementation CellWithButtonByNibTableViewCellViewModel

- (RACCommand*)addButtonCommand {
    return DY_LAZY(_addButtonCommand,([[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            CellWithButtonByNibTableViewCellViewModel *viewModel = [[CellWithButtonByNibTableViewCellViewModel alloc] init];
            viewModel.title = [NSString stringWithFormat:@"%@", [NSDate date]];
            [subscriber sendNext:viewModel];
            return nil;
        }];
    }]));
}

- (NSString *) cellIdentifier{
    return @"CellWithButtonByNibTableViewCell";
}

@end
