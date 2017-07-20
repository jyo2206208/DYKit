//
//  DYKitDemoTests.m
//  DYKitDemoTests
//
//  Created by DuYe on 2017/7/8.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface DYKitDemoTests : XCTestCase

@end

@implementation DYKitDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:2 inSection:1];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:2 inSection:1];
    if ([indexPath1 isEqual:indexPath2]) {
        NSLog(@"yes");
    } else {
        NSLog(@"no");
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
