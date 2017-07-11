//
//  BlueTableViewCellViewModel.h
//  DYKitDemo
//
//  Created by DuYe on 2017/7/9.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYTableViewCellViewModelProtocol.h"

@interface BlueTableViewCellViewModel : NSObject<DYTableViewCellViewModelProtocol>

@property (nonatomic, copy) NSString *title;

@end
