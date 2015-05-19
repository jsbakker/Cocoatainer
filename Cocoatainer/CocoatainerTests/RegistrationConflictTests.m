//
//  RegistrationConflictTests.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-19.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CCTCocoatainer.h"
#import "TestTypes/NoDeps.h"

@interface RegistrationConflictTests : XCTestCase

@end

@implementation RegistrationConflictTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRegisterComponentSameClassTwiceThrows
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class]
                    initsWith:^{
                        return @"foo";
                    }];

    XCTAssertThrows([config registerComponent:[NSString class]
                                    initsWith:^{
                                        return @"bar";
                                    }],
                    @"Cannot register the same type twice.");
}

- (void)testRegisterComponentSameProtocolTwiceThrows
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA)
                    initsWith:^{
                        return [[NoDepsA alloc] init];
                    }];

    XCTAssertThrows([config registerComponent:@protocol(INoDepsA)
                                    initsWith:^{
                                        return [[NoDepsA alloc] init];
                                    }],
                    @"Cannot register the same type twice.");
}

- (void)testRegisterComponentSameClassAsDependency
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:[NSString class]
                                    initsWith:
                     ^(NSString* d1){
                         return d1;
                     }],
                    @"Dependency cannot be same type as component.");
}

- (void)testRegisterComponentSameProtocolAsDependency
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    XCTAssertThrows([config registerComponent:@protocol(INoDepsA)
                                 dependentOn1:@protocol(INoDepsA)
                                    initsWith:
                     ^(id<INoDepsA> d1){
                         return [[NoDepsA alloc] init];
                     }],
                    @"Dependency cannot be same type as component.");
}

@end
