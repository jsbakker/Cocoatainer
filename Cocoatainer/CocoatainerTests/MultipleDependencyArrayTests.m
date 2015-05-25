//
//  MultipleDependencyArrayTests.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-24.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CCTCocoatainer.h"
#import "TestTypes/DependsOnMultiple.h"

@interface MultipleDependencyArrayTests : XCTestCase

@end

@implementation MultipleDependencyArrayTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResolveDependsOnArray2
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                  dependentOn:@[[NSString class],
                                [NSString class]]
                    initsWith:^(NSArray* dependencies)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 dependencies[0],
                 dependencies[1],
                 nil];
     }];

    id<IDependsOnMultiple> testObject =
    [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 2, "Injection count.");
}

- (void)testResolveDependsOnArray3
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                  dependentOn:@[[NSString class],
                                [NSString class],
                                [NSString class]]
                    initsWith:^(NSArray* dependencies)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 dependencies[0],
                 dependencies[1],
                 dependencies[2],
                 nil];
     }];

    id<IDependsOnMultiple> testObject =
    [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 3, "Injection count.");
}

- (void)testResolveDependsOnArray4
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                  dependentOn:@[[NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class]]
                    initsWith:^(NSArray* dependencies)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 dependencies[0],
                 dependencies[1],
                 dependencies[2],
                 dependencies[3],
                 nil];
     }];

    id<IDependsOnMultiple> testObject =
    [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 4, "Injection count.");
}

- (void)testResolveDependsOnArray5
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                  dependentOn:@[[NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class]]
                    initsWith:^(NSArray* dependencies)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 dependencies[0],
                 dependencies[1],
                 dependencies[2],
                 dependencies[3],
                 dependencies[4],
                 nil];
     }];

    id<IDependsOnMultiple> testObject =
    [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 5, "Injection count.");
}

- (void)testResolveDependsOnArray6
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                  dependentOn:@[[NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class]]
                    initsWith:^(NSArray* dependencies)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 dependencies[0],
                 dependencies[1],
                 dependencies[2],
                 dependencies[3],
                 dependencies[4],
                 dependencies[5],
                 nil];
     }];

    id<IDependsOnMultiple> testObject =
    [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 6, "Injection count.");
}

- (void)testResolveDependsOnArray7
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                  dependentOn:@[[NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class]]
                    initsWith:^(NSArray* dependencies)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 dependencies[0],
                 dependencies[1],
                 dependencies[2],
                 dependencies[3],
                 dependencies[4],
                 dependencies[5],
                 dependencies[6],
                 nil];
     }];

    id<IDependsOnMultiple> testObject =
    [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 7, "Injection count.");
}

- (void)testResolveDependsOnArray8
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                  dependentOn:@[[NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class]]
                    initsWith:^(NSArray* dependencies)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 dependencies[0],
                 dependencies[1],
                 dependencies[2],
                 dependencies[3],
                 dependencies[4],
                 dependencies[5],
                 dependencies[6],
                 dependencies[7],
                 nil];
     }];

    id<IDependsOnMultiple> testObject =
    [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 8, "Injection count.");
}

- (void)testResolveDependsOnArray9
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                  dependentOn:@[[NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class]]
                    initsWith:^(NSArray* dependencies)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 dependencies[0],
                 dependencies[1],
                 dependencies[2],
                 dependencies[3],
                 dependencies[4],
                 dependencies[5],
                 dependencies[6],
                 dependencies[7],
                 dependencies[8],
                 nil];
     }];

    id<IDependsOnMultiple> testObject =
    [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 9, "Injection count.");
}

- (void)testResolveDependsOnArray10
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                  dependentOn:@[[NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class],
                                [NSString class]]
                    initsWith:^(NSArray* dependencies)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 dependencies[0],
                 dependencies[1],
                 dependencies[2],
                 dependencies[3],
                 dependencies[4],
                 dependencies[5],
                 dependencies[6],
                 dependencies[7],
                 dependencies[8],
                 dependencies[9],
                 nil];
     }];

    id<IDependsOnMultiple> testObject =
    [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 10, "Injection count.");
}

@end
