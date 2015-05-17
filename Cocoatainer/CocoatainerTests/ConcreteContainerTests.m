//
//  ConcreteContainerTests.m
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

@interface ConcreteContainerTests : XCTestCase

@end

@implementation ConcreteContainerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResolveUnregisteredClassThrows
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    XCTAssertThrows([config resolveComponent:[NoDepsA class]],
                    @"Cannot resolve unregistered component.");
}

- (void)testResolveInjectedInstanceByInterface
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA)
                 withInstance:[[NoDepsA alloc] init]];

    id testObject = [config resolveComponent:@protocol(INoDepsA)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(INoDepsA)],
                  "testObject conforms to TestProtocol.");
    XCTAssertTrue([testObject isKindOfClass:[NoDepsA class]],
                  "testObject is of type TestClass.");
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

    [config registerComponent:[NoDepsA class] initsWith:
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

    [config registerComponent:[NoDepsA class] initsWith:
     ^{
         return [[NoDepsA alloc] init];
     }];

    [config registerComponent:[DependsOn1A class]
                 dependentOn1:[NoDepsA class]
                    initsWith:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    id testObject = [config resolveComponent:[DependsOn1A class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject isKindOfClass:[DependsOn1A class]],
                  "testObject is of type TestClass.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] isKindOfClass:[NoDepsA class]],
                  "dependency1 is of type TestClass.");
}

- (void)testResolveDependsOn1InjectedInstance
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NoDepsA class]
                 withInstance:[[NoDepsA alloc] init]];

    [config registerComponent:[DependsOn1A class]
                 dependentOn1:[NoDepsA class]
                    initsWith:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    id testObject = [config resolveComponent:[DependsOn1A class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject isKindOfClass:[DependsOn1A class]],
                  "testObject is of type TestClass.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] isKindOfClass:[NoDepsA class]],
                  "dependency1 is of type TestClass.");
}

- (void)testResolveDependsOn2
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NoDepsA class] initsWith:
     ^{
         return [[NoDepsA alloc] init];
     }];

    [config registerComponent:[NoDepsB class] initsWith:
     ^{
         return [[NoDepsB alloc] init];
     }];

    [config registerComponent:[DependsOn2A class]
                 dependentOn1:[NoDepsA class]
                         and2:[NoDepsB class]
                    initsWith:^(id<INoDepsA> d1, id<INoDepsB> d2)
     {
         return [[DependsOn2A alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:[DependsOn2A class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject isKindOfClass:[DependsOn2A class]],
                  "testObject is of type TestClass.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] isKindOfClass:[NoDepsA class]],
                  "dependency1 is of type TestClass.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] isKindOfClass:[NoDepsB class]],
                  "dependency2 is of type TestClass.");
}

- (void)testResolveDependsOn2InjectedInstanceD1
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NoDepsA class]
                 withInstance:[[NoDepsA alloc] init]];

    [config registerComponent:[NoDepsB class] initsWith:
     ^{
         return [[NoDepsB alloc] init];
     }];

    [config registerComponent:[DependsOn2A class]
                 dependentOn1:[NoDepsA class]
                         and2:[NoDepsB class]
                    initsWith:^(id<INoDepsA> d1, id<INoDepsB> d2)
     {
         return [[DependsOn2A alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:[DependsOn2A class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject isKindOfClass:[DependsOn2A class]],
                  "testObject is of type TestClass.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] isKindOfClass:[NoDepsA class]],
                  "dependency1 is of type TestClass.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] isKindOfClass:[NoDepsB class]],
                  "dependency2 is of type TestClass.");
}

- (void)testResolveNestedDependencies
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NoDepsA class] initsWith:
     ^{
         return [[NoDepsA alloc] init];
     }];

    [config registerComponent:[NoDepsB class] initsWith:
     ^{
         return [[NoDepsB alloc] init];
     }];

    [config registerComponent:[DependsOn1A class]
                 dependentOn1:[NoDepsA class]
                    initsWith:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    [config registerComponent:[NoDepsB class] initsWith:
     ^{
         return [[NoDepsB alloc] init];
     }];

    [config registerComponent:[DependsOn2B class]
                 dependentOn1:[DependsOn1A class]
                         and2:[NoDepsB class]
                    initsWith:^(id<IDependsOn1A> d1, id<INoDepsB> d2)
     {
         return [[DependsOn2B alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:[DependsOn2B class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject isKindOfClass:[DependsOn2B class]],
                  "testObject is of type TestClass.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] isKindOfClass:[DependsOn1A class]],
                  "dependency1 is of type TestClass.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] isKindOfClass:[NoDepsB class]],
                  "dependency2 is of type TestClass.");
}

- (void)testResolveNestedDependenciesInjectedInstances
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NoDepsA class]
                 withInstance:[[NoDepsA alloc] init]];

    [config registerComponent:[NoDepsB class]
                 withInstance:[[NoDepsB alloc] init]];

    [config registerComponent:[DependsOn1A class]
                 dependentOn1:[NoDepsA class]
                    initsWith:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    [config registerComponent:[NoDepsB class] initsWith:
     ^{
         return [[NoDepsB alloc] init];
     }];

    [config registerComponent:[DependsOn2B class]
                 dependentOn1:[DependsOn1A class]
                         and2:[NoDepsB class]
                    initsWith:^(id<IDependsOn1A> d1, id<INoDepsB> d2)
     {
         return [[DependsOn2B alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:[DependsOn2B class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject isKindOfClass:[DependsOn2B class]],
                  "testObject is of type TestClass.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] isKindOfClass:[DependsOn1A class]],
                  "dependency1 is of type TestClass.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] isKindOfClass:[NoDepsB class]],
                  "dependency2 is of type TestClass.");
}

- (void)testResolveNestedSharedDependencies
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NoDepsA class] initsWith:
     ^{
         return [[NoDepsA alloc] init];
     }];

    [config registerComponent:[DependsOn1A class]
                 dependentOn1:[NoDepsA class]
                    initsWith:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    [config registerComponent:[DependsOn2C class]
                 dependentOn1:[DependsOn1A class]
                         and2:[NoDepsA class]
                    initsWith:^(id<IDependsOn1A> d1, id<INoDepsA> d2)
     {
         return [[DependsOn2C alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:[DependsOn2C class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject isKindOfClass:[DependsOn2C class]],
                  "testObject is of type TestClass.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] isKindOfClass:[DependsOn1A class]],
                  "dependency1 is of type TestClass.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] isKindOfClass:[NoDepsA class]],
                  "dependency2 is of type TestClass.");
}

- (void)testResolveNestedSharedDependenciesInjectedInstance
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    id<INoDepsA> noDepsA = [[NoDepsA alloc] init];
    [config registerComponent:[NoDepsA class]
                 withInstance:noDepsA];

    [config registerComponent:[DependsOn1A class]
                 withInstance:[[DependsOn1A alloc] initWithD1:noDepsA]];

    [config registerComponent:[DependsOn2C class]
                 dependentOn1:[DependsOn1A class]
                         and2:[NoDepsA class]
                    initsWith:^(id<IDependsOn1A> d1, id<INoDepsA> d2)
     {
         return [[DependsOn2C alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:[DependsOn2C class]];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject isKindOfClass:[DependsOn2C class]],
                  "testObject is of type TestClass.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] isKindOfClass:[DependsOn1A class]],
                  "dependency1 is of type TestClass.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] isKindOfClass:[NoDepsA class]],
                  "dependency2 is of type TestClass.");
}

@end
