//
//  TypeChecking.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-18.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CCTCocoatainer.h"

@interface TypeCheckingTests : XCTestCase

@end

@implementation TypeCheckingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRegisterObjectComponentWithInstanceThrows
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSString* foo = @"foo";
    XCTAssertThrows([config registerComponent:foo withInstance:foo],
                    @"Registring object as component type throws");
}

- (void)testRegisterNilComponentWithInstanceThrows
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSString* foo;
    XCTAssertThrows([config registerComponent:foo withInstance:foo],
                    @"Registring nil as component type throws");
}

- (void)testRegisterObjectComponentWithDependencies0Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSString* foo = @"foo";
    XCTAssertThrows([config registerComponent:foo initsWith:^{return @"foo";}],
                    @"Registring instance as type throws");
}

- (void)testRegisterNilComponentWithDependencies0Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSString* foo;
    XCTAssertThrows([config registerComponent:foo initsWith:^{return @"foo";}],
                    @"Registring instance as type throws");
}

- (void)testRegisterObjectComponentWithDependencies1Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSString* foo = @"foo";
    XCTAssertThrows([config registerComponent:foo
                                 dependentOn1:[NSNumber class]
                                    initsWith:
                     ^(NSNumber* d1){
                         return [d1 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterObjectDependencyWithDependencies1Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSNumber* foo = @42;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:foo
                                    initsWith:
                     ^(NSNumber* d1){
                         return [d1 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterNilDependencyWithDependencies1Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSString* foo;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:foo
                                    initsWith:
                     ^(NSNumber* d1){
                         return [d1 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterObjectDependencyWithDependencies2Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSNumber* foo = @42;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:[NSNumber class]
                                         and2:foo
                                    initsWith:
                     ^(NSNumber* d1, NSNumber* d2){
                         return [d2 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterNilDependencyWithDependencies2Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSNumber* foo;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:[NSNumber class]
                                         and2:foo
                                    initsWith:
                     ^(NSNumber* d1, NSNumber* d2){
                         return [d2 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterObjectDependencyWithDependencies3Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSNumber* foo = @42;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:[NSNumber class]
                                         and2:[NSNumber class]
                                         and3:foo
                                    initsWith:
                     ^(NSNumber* d1, NSNumber* d2, NSNumber* d3){
                         return [d3 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterNilDependencyWithDependencies3Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSNumber* foo;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:[NSNumber class]
                                         and2:[NSNumber class]
                                         and3:foo
                                    initsWith:
                     ^(NSNumber* d1, NSNumber* d2, NSNumber* d3){
                         return [d3 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterObjectDependencyWithDependencies4Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSNumber* foo = @42;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:[NSNumber class]
                                         and2:[NSNumber class]
                                         and3:[NSNumber class]
                                         and4:foo
                                    initsWith:
                     ^(NSNumber* d1, NSNumber* d2, NSNumber* d3, NSNumber* d4){
                         return [d4 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterNilDependencyWithDependencies4Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSNumber* foo;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:[NSNumber class]
                                         and2:[NSNumber class]
                                         and3:[NSNumber class]
                                         and4:foo
                                    initsWith:
                     ^(NSNumber* d1, NSNumber* d2, NSNumber* d3, NSNumber* d4){
                         return [d4 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterObjectDependencyWithDependencies5Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSNumber* foo = @42;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:[NSNumber class]
                                         and2:[NSNumber class]
                                         and3:[NSNumber class]
                                         and4:[NSNumber class]
                                         and5:foo
                                    initsWith:
                     ^(NSNumber* d1, NSNumber* d2, NSNumber* d3,
                       NSNumber* d4, NSNumber* d5){
                         return [d5 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterNilDependencyWithDependencies5Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSNumber* foo;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:[NSNumber class]
                                         and2:[NSNumber class]
                                         and3:[NSNumber class]
                                         and4:[NSNumber class]
                                         and5:foo
                                    initsWith:
                     ^(NSNumber* d1, NSNumber* d2, NSNumber* d3,
                       NSNumber* d4, NSNumber* d5){
                         return [d5 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterObjectDependencyWithDependencies6Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSNumber* foo = @42;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:[NSNumber class]
                                         and2:[NSNumber class]
                                         and3:[NSNumber class]
                                         and4:[NSNumber class]
                                         and5:[NSNumber class]
                                         and6:foo
                                    initsWith:
                     ^(NSNumber* d1, NSNumber* d2, NSNumber* d3,
                       NSNumber* d4, NSNumber* d5, NSNumber* d6){
                         return [d6 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterNilDependencyWithDependencies6Throws
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSNumber* foo;
    XCTAssertThrows([config registerComponent:[NSString class]
                                 dependentOn1:[NSNumber class]
                                         and2:[NSNumber class]
                                         and3:[NSNumber class]
                                         and4:[NSNumber class]
                                         and5:[NSNumber class]
                                         and6:foo
                                    initsWith:
                     ^(NSNumber* d1, NSNumber* d2, NSNumber* d3,
                       NSNumber* d4, NSNumber* d5, NSNumber* d6){
                         return [d6 stringValue];
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterObjectComponentWithDependenciesArrayThrows
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSString* foo = @"foo";
    XCTAssertThrows([config registerComponent:foo
                                  dependentOn:@[[NSString class]]
                                    initsWith:
                     ^(id d1){
                         return @"bar";
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterObjectDependencyWithDependenciesArrayThrows
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSString* foo = @"foo";
    XCTAssertThrows([config registerComponent:[NSString class]
                                  dependentOn:@[foo]
                                    initsWith:
                     ^(id d1){
                         return @"bar";
                     }],
                    @"Registring instance as type throws");
}

- (void)testRegisterNilDependencyWithDependenciesArrayThrows
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    NSString* foo;
    XCTAssertThrows([config registerComponent:[NSString class]
                                  dependentOn:@[foo]
                                    initsWith:
                     ^(id d1){
                         return @"bar";
                     }],
                    @"Registring instance as type throws");
}

@end
