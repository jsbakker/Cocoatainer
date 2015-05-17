//
//  ContainerTests.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-16.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CCTCocoatainer.h"

#import "TestTypes/NoDeps.h"
#import "TestTypes/DependsOn1.h"
#import "TestTypes/DependsOn2.h"

@interface ContainerTests : XCTestCase

@end

@implementation ContainerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResolveInjectedInstance
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NoDepsA class]
                 withInstance:[[NoDepsA alloc] init]];

    id testObject = [config resolveComponent:[NoDepsA class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(INoDepsA)],
                  "testObject conforms to TestProtocol.");
    XCTAssertTrue([testObject isKindOfClass:[NoDepsA class]],
                  "testObject is of type TestClass.");
}

- (void)testResolveNoDeps
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NoDepsA class] withBlock:
     ^{
         return [[NoDepsA alloc] init];
     }];

    id testObject = [config resolveComponent:[NoDepsA class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(INoDepsA)],
                  "testObject conforms to TestProtocol.");
    XCTAssertTrue([testObject isKindOfClass:[NoDepsA class]],
                  "testObject is of type TestClass.");
}

- (void)testResolveDependsOn1
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NoDepsA class] withBlock:
     ^{
         return [[NoDepsA alloc] init];
     }];

    [config registerComponent:[DependsOn1A class]
                 dependentOn1:[NoDepsA class]
                    withBlock:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    id testObject = [config resolveComponent:[DependsOn1A class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOn1A)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] conformsToProtocol:@protocol(INoDepsA)],
                  "testObject conforms to TestProtocol.");
}

- (void)testResolveNestedDependencies
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NoDepsA class] withBlock:
     ^{
         return [[NoDepsA alloc] init];
     }];

    [config registerComponent:[NoDepsB class] withBlock:
     ^{
         return [[NoDepsB alloc] init];
     }];

    [config registerComponent:[DependsOn1A class]
                 dependentOn1:[NoDepsA class]
                    withBlock:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    [config registerComponent:[NoDepsB class] withBlock:
     ^{
         return [[NoDepsB alloc] init];
     }];

    [config registerComponent:[DependsOn2B class]
                 dependentOn1:[DependsOn1A class]
                         and2:[NoDepsB class]
                    withBlock:^(id<IDependsOn1A> d1, id<INoDepsB> d2)
     {
         return [[DependsOn2B alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:[DependsOn2B class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOn2B)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] conformsToProtocol:@protocol(IDependsOn1A)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] conformsToProtocol:@protocol(INoDepsB)],
                  "testObject conforms to TestProtocol.");
}

@end
