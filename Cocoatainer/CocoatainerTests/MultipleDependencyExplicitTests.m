//
//  MultipleDependencyExplicitTests.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-17.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CCTCocoatainer.h"
#import "TestTypes/DependsOnMultiple.h"

@interface MultipleDependencyExplicitTests : XCTestCase

@end

@implementation MultipleDependencyExplicitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRegisterAbstractAndConcreteAndResolveDifferentObjects
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:[NSNumber class] initsWith:
     ^{
         return @1000;
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                 dependentOn1:[NSString class]
                         and2:[NSNumber class]
                    initsWith:
     ^(NSString* d1, NSNumber* d2)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:d1, d2, nil];
     }];

    [config registerComponent:[DependsOnMultiple class]
                 dependentOn1:[NSString class]
                         and2:[NSString class]
                    initsWith:
     ^(NSString* d1, NSString* d2)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:d1, d2, nil];
     }];

    id<IDependsOnMultiple> abstractObject =
        [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(abstractObject, "abstractObject is not nil.");
    XCTAssertTrue([abstractObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "abstractObject conforms to protocol IDependsOnMultiple.");

    NSArray* abstractDepends = [abstractObject injections];
    XCTAssertTrue(abstractDepends.count == 2, "Injection count.");

    id abstractInjected1 = abstractDepends[0];
    id abstractInjected2 = abstractDepends[1];
    XCTAssertTrue([abstractInjected1 isKindOfClass:[NSString class]]);
    XCTAssertTrue([abstractInjected2 isKindOfClass:[NSNumber class]]);


    DependsOnMultiple* concreteObject =
        [config resolveComponent:[DependsOnMultiple class]];

    XCTAssertNotNil(concreteObject, "concreteObject is not nil.");
    XCTAssertTrue([concreteObject isKindOfClass:[DependsOnMultiple class]],
                  "concreteObject is kind of class DependsOnMultiple.");

    NSArray* concreteDepends = [concreteObject injections];
    XCTAssertTrue(concreteDepends.count == 2, "Injection count.");

    id concreteInjected1 = concreteDepends[0];
    id concreteInjected2 = concreteDepends[1];
    XCTAssertTrue([concreteInjected1 isKindOfClass:[NSString class]]);
    XCTAssertTrue([concreteInjected2 isKindOfClass:[NSString class]]);
}

- (void)testResolveDependsOn2
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:[NSNumber class] initsWith:
     ^{
         return @1000;
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                 dependentOn1:[NSString class]
                         and2:[NSNumber class]
                    initsWith:
     ^(NSString* d1, NSNumber* d2)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:d1, d2, nil];
     }];

    id<IDependsOnMultiple> testObject =
        [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 2, "Injection count.");

    id injected1 = depends[0];
    id injected2 = depends[1];
    XCTAssertTrue([injected1 isKindOfClass:[NSString class]]);
    XCTAssertTrue([injected2 isKindOfClass:[NSNumber class]]);
}

- (void)testResolveDependsOn3
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                 dependentOn1:[NSString class]
                         and2:[NSString class]
                         and3:[NSString class]
                    initsWith:
     ^(NSString* d1, NSString* d2, NSString* d3)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 d1, d2, d3, nil];
     }];

    id<IDependsOnMultiple> testObject =
        [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 3, "Injection count.");
}

- (void)testResolveDependsOn4
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                 dependentOn1:[NSString class]
                         and2:[NSString class]
                         and3:[NSString class]
                         and4:[NSString class]
                    initsWith:
     ^(NSString* d1, NSString* d2, NSString* d3, NSString* d4)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 d1, d2, d3, d4, nil];
     }];

    id<IDependsOnMultiple> testObject =
        [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 4, "Injection count.");
}

- (void)testResolveDependsOn5
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                 dependentOn1:[NSString class]
                         and2:[NSString class]
                         and3:[NSString class]
                         and4:[NSString class]
                         and5:[NSString class]
                    initsWith:
     ^(NSString* d1, NSString* d2, NSString* d3, NSString* d4, NSString* d5)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 d1, d2, d3, d4, d5, nil];
     }];

    id<IDependsOnMultiple> testObject =
        [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 5, "Injection count.");
}

- (void)testResolveDependsOn6
{
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:[NSString class] initsWith:
     ^{
         return @"Injected";
     }];

    [config registerComponent:@protocol(IDependsOnMultiple)
                 dependentOn1:[NSString class]
                         and2:[NSString class]
                         and3:[NSString class]
                         and4:[NSString class]
                         and5:[NSString class]
                         and6:[NSString class]
                    initsWith:
     ^(NSString* d1, NSString* d2, NSString* d3,
       NSString* d4, NSString* d5, NSString* d6)
     {
         return [[DependsOnMultiple alloc] initWithDependencies:
                 d1, d2, d3, d4, d5, d6, nil];
     }];

    id<IDependsOnMultiple> testObject =
        [config resolveComponent:@protocol(IDependsOnMultiple)];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOnMultiple)],
                  "testObject conforms to protocol IDependsOnMultiple.");

    NSArray* depends = [testObject injections];
    XCTAssertTrue(depends.count == 6, "Injection count.");
}

@end
