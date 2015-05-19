//
//  AbstractCocoatainerTests.m
//  CocoatainerTests
//
//  Created by Jeffrey Bakker on 2015-05-15.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CCTAbstractCocoatainer.h"

#import "TestTypes/NoDeps.h"
#import "TestTypes/DependsOn1.h"
#import "TestTypes/DependsOn2.h"

@interface AbstractContainerTests : XCTestCase

@end

@implementation AbstractContainerTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testRestrictRegisterConcreteTypes
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    XCTAssertThrows([config registerComponent:[NoDepsA class]
                                 withInstance:[[NoDepsA alloc] init]],
                    @"Cannot register concrete types in abstract mode.");
}

- (void)testRestrictResolveConcreteTypes
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA)
                 withInstance:[[NoDepsA alloc] init]];

    XCTAssertThrows([config resolveComponent:[NoDepsA class]],
                    @"Cannot resolve concrete types in abstract container.");
}

- (void)testResolveUnregisteredProtocolThrows
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    XCTAssertThrows([config resolveComponent:@protocol(INoDepsA)],
                    @"Cannot resolve unregistered component.");
}

- (void)testResolveInjectedInstance
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA)
                 withInstance:[[NoDepsA alloc] init]];

    id testObject = [config resolveComponent:@protocol(INoDepsA)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(INoDepsA)],
                  "testObject conforms to TestProtocol.");
    XCTAssertTrue([testObject isKindOfClass:[NoDepsA class]],
                  "testObject is of type TestClass.");
}

- (void)testResolveNoDeps
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA) initsWith:
     ^{
         return [[NoDepsA alloc] init];
     }];

    id testObject = [config resolveComponent:@protocol(INoDepsA)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(INoDepsA)],
                  "testObject conforms to TestProtocol.");
    XCTAssertTrue([testObject isKindOfClass:[NoDepsA class]],
                  "testObject is of type TestClass.");
}

- (void)testResolveDependsOn1
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA) initsWith:
     ^{
         return [[NoDepsA alloc] init];
     }];

    [config registerComponent:@protocol(IDependsOn1A)
                 dependentOn1:@protocol(INoDepsA)
                    initsWith:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    id testObject = [config resolveComponent:@protocol(IDependsOn1A)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOn1A)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] conformsToProtocol:@protocol(INoDepsA)],
                  "dependency1 conforms to TestProtocol.");
}

- (void)testResolveDependsOn1InjectedInstance
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA)
                 withInstance:[[NoDepsA alloc] init]];

    [config registerComponent:@protocol(IDependsOn1A)
                 dependentOn1:@protocol(INoDepsA)
                    initsWith:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    id testObject = [config resolveComponent:@protocol(IDependsOn1A)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOn1A)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] conformsToProtocol:@protocol(INoDepsA)],
                  "dependency1 conforms to TestProtocol.");
}

- (void)testResolveDependsOn2
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA) initsWith:
     ^{
         return [[NoDepsA alloc] init];
     }];

    [config registerComponent:@protocol(INoDepsB) initsWith:
     ^{
         return [[NoDepsB alloc] init];
     }];

    [config registerComponent:@protocol(IDependsOn2A)
                 dependentOn1:@protocol(INoDepsA)
                         and2:@protocol(INoDepsB)
                    initsWith:^(id<INoDepsA> d1, id<INoDepsB> d2)
     {
         return [[DependsOn2A alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:@protocol(IDependsOn2A)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOn2A)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] conformsToProtocol:@protocol(INoDepsA)],
                  "dependency1 conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] conformsToProtocol:@protocol(INoDepsB)],
                  "dependency2 conforms to TestProtocol.");
}

- (void)testResolveDependsOn2InjectedInstanceD1
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA)
                 withInstance:[[NoDepsA alloc] init]];

    [config registerComponent:@protocol(INoDepsB) initsWith:
     ^{
         return [[NoDepsB alloc] init];
     }];

    [config registerComponent:@protocol(IDependsOn2A)
                 dependentOn1:@protocol(INoDepsA)
                         and2:@protocol(INoDepsB)
                    initsWith:^(id<INoDepsA> d1, id<INoDepsB> d2)
     {
         return [[DependsOn2A alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:@protocol(IDependsOn2A)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOn2A)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] conformsToProtocol:@protocol(INoDepsA)],
                  "dependency1 conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] conformsToProtocol:@protocol(INoDepsB)],
                  "dependency2 conforms to TestProtocol.");
}

- (void)testResolveNestedDependencies
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA) initsWith:
     ^{
         return [[NoDepsA alloc] init];
     }];

    [config registerComponent:@protocol(INoDepsB) initsWith:
     ^{
         return [[NoDepsB alloc] init];
     }];

    [config registerComponent:@protocol(IDependsOn1A)
                 dependentOn1:@protocol(INoDepsA)
                    initsWith:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    [config registerComponent:@protocol(IDependsOn2B)
                 dependentOn1:@protocol(IDependsOn1A)
                         and2:@protocol(INoDepsB)
                    initsWith:^(id<IDependsOn1A> d1, id<INoDepsB> d2)
     {
         return [[DependsOn2B alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:@protocol(IDependsOn2B)];

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

- (void)testResolveNestedDependenciesInjectedInstances
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA)
                 withInstance:[[NoDepsA alloc] init]];

    [config registerComponent:@protocol(INoDepsB)
                 withInstance:[[NoDepsB alloc] init]];

    [config registerComponent:@protocol(IDependsOn1A)
                 dependentOn1:@protocol(INoDepsA)
                    initsWith:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    [config registerComponent:@protocol(IDependsOn2B)
                 dependentOn1:@protocol(IDependsOn1A)
                         and2:@protocol(INoDepsB)
                    initsWith:^(id<IDependsOn1A> d1, id<INoDepsB> d2)
     {
         return [[DependsOn2B alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:@protocol(IDependsOn2B)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOn2B)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] conformsToProtocol:@protocol(IDependsOn1A)],
                  "dependency1 conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] conformsToProtocol:@protocol(INoDepsB)],
                  "dependency2 conforms to TestProtocol.");
}

- (void)testResolveNestedSharedDependencies
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    [config registerComponent:@protocol(INoDepsA) initsWith:
     ^{
         return [[NoDepsA alloc] init];
     }];

    [config registerComponent:@protocol(IDependsOn1A)
                 dependentOn1:@protocol(INoDepsA)
                    initsWith:^(id<INoDepsA> d1)
     {
         return [[DependsOn1A alloc] initWithD1:d1];
     }];

    [config registerComponent:@protocol(IDependsOn2C)
                 dependentOn1:@protocol(IDependsOn1A)
                         and2:@protocol(INoDepsA)
                    initsWith:^(id<IDependsOn1A> d1, id<INoDepsA> d2)
     {
         return [[DependsOn2C alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:@protocol(IDependsOn2C)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOn2C)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] conformsToProtocol:@protocol(IDependsOn1A)],
                  "dependency1 conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] conformsToProtocol:@protocol(INoDepsA)],
                  "dependency2 conforms to TestProtocol.");
}

- (void)testResolveNestedSharedDependenciesInjectedInstance
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    id<INoDepsA> noDepsA = [[NoDepsA alloc] init];
    [config registerComponent:@protocol(INoDepsA)
                 withInstance:noDepsA];

    [config registerComponent:@protocol(IDependsOn1A)
                 withInstance:[[DependsOn1A alloc] initWithD1:noDepsA]];

    [config registerComponent:@protocol(IDependsOn2C)
                 dependentOn1:@protocol(IDependsOn1A)
                         and2:@protocol(INoDepsA)
                    initsWith:^(id<IDependsOn1A> d1, id<INoDepsA> d2)
     {
         return [[DependsOn2C alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:@protocol(IDependsOn2C)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOn2C)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] conformsToProtocol:@protocol(IDependsOn1A)],
                  "dependency1 conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] conformsToProtocol:@protocol(INoDepsA)],
                  "dependency2 conforms to TestProtocol.");
}

@end
