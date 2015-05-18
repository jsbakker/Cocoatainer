//
//  ContainerScopeTests.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-17.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CCTCocoatainer.h"
#import "TestTypes/DependsOnMultiple.h"
#import "TestTypes/DescopeLogger.h"
#import "TestTypes/StartupLogger.h"
#import "Logging/ArrayLog.h"
#import "Logging/ILogger.h"
#import "Logging/ILog.h"

@interface ContainerScopeTests : XCTestCase

@end

@implementation ContainerScopeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testScopeEndsTriggersDeallocIfNoOutsideRefs
{
    NSString* expected1 = @"dealloc in DescopeLoggerA";
    NSString* expected2 = @"dealloc in DescopeLoggerB";

    id<ILog> log = [[ArrayLog alloc] init];

    @autoreleasepool
    {
        CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

        [config registerComponent:@protocol(ILog)
                     withInstance:log];

        [config registerComponent:@protocol(ILoggerA)
                     dependentOn1:@protocol(ILog)
                        initsWith:^(id<ILog> log){
                            return [[DescopeLoggerA alloc] initWithLog:log];
                        }];

        [config registerComponent:@protocol(ILoggerB)
                     dependentOn1:@protocol(ILog)
                        initsWith:^(id<ILog> log){
                            return [[DescopeLoggerB alloc] initWithLog:log];
                        }];

        [config registerComponent:@protocol(IDependsOnMultiple)
                     dependentOn1:@protocol(ILoggerA)
                             and2:@protocol(ILoggerB)
                        initsWith:^(id<ILoggerA> d1, id<ILoggerB> d2)
         {
             return [[DependsOnMultiple alloc]
                     initWithDependencies:d1, d2, nil];
         }];

        id testObject = [config resolveComponent:@protocol(IDependsOnMultiple)];

        XCTAssertNotNil(testObject, "testObject is not nil.");
        XCTAssertTrue([testObject conformsToProtocol:
                       @protocol(IDependsOnMultiple)],
                      "testObject conforms to TestProtocol.");

        XCTAssertTrue([log getLines].count == 0, @"No delloc yet logged.");
    } // End of container scope

    NSArray* logLines = [log getLines];
    XCTAssertTrue(logLines.count == 2, @"Dealloc on 2 objects logged.");
    XCTAssertTrue([logLines containsObject:expected1]);
    XCTAssertTrue([logLines containsObject:expected2]);
}

- (void)testScopeEndsNoDeallocWhenOutsideRefs
{
    id<ILog> log = [[ArrayLog alloc] init];
    id dependsMultiple;

    @autoreleasepool
    {
        CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

        [config registerComponent:@protocol(ILog)
                     withInstance:log];

        [config registerComponent:@protocol(ILoggerA)
                     dependentOn1:@protocol(ILog)
                        initsWith:^(id<ILog> log){
                            return [[DescopeLoggerA alloc] initWithLog:log];
                        }];

        [config registerComponent:@protocol(ILoggerB)
                     dependentOn1:@protocol(ILog)
                        initsWith:^(id<ILog> log){
                            return [[DescopeLoggerB alloc] initWithLog:log];
                        }];

        [config registerComponent:@protocol(IDependsOnMultiple)
                     dependentOn1:@protocol(ILoggerA)
                             and2:@protocol(ILoggerB)
                        initsWith:^(id<ILoggerA> d1, id<ILoggerB> d2)
         {
             return [[DependsOnMultiple alloc]
                     initWithDependencies:d1, d2, nil];
         }];

        id testObject = [config resolveComponent:@protocol(IDependsOnMultiple)];
        dependsMultiple = testObject;

        XCTAssertNotNil(testObject, "testObject is not nil.");
        XCTAssertTrue([testObject conformsToProtocol:
                       @protocol(IDependsOnMultiple)],
                      "testObject conforms to TestProtocol.");

        XCTAssertTrue([log getLines].count == 0, @"No delloc yet logged.");
    } // End of container scope

    XCTAssertTrue([log getLines].count == 0, @"No delloc yet logged.");
}

- (void)testScopeEndsNoDeallocUntilOutsideRefEnds
{
    NSString* expected1 = @"dealloc in DescopeLoggerA";
    NSString* expected2 = @"dealloc in DescopeLoggerB";

    id<ILog> log = [[ArrayLog alloc] init];

    @autoreleasepool
    {
        id dependsMultiple;

        @autoreleasepool
        {
            CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

            [config registerComponent:@protocol(ILog)
                         withInstance:log];

            [config registerComponent:@protocol(ILoggerA)
                         dependentOn1:@protocol(ILog)
                            initsWith:^(id<ILog> log){
                                return [[DescopeLoggerA alloc] initWithLog:log];
                            }];

            [config registerComponent:@protocol(ILoggerB)
                         dependentOn1:@protocol(ILog)
                            initsWith:^(id<ILog> log){
                                return [[DescopeLoggerB alloc] initWithLog:log];
                            }];

            [config registerComponent:@protocol(IDependsOnMultiple)
                         dependentOn1:@protocol(ILoggerA)
                                 and2:@protocol(ILoggerB)
                            initsWith:^(id<ILoggerA> d1, id<ILoggerB> d2)
             {
                 return [[DependsOnMultiple alloc]
                         initWithDependencies:d1, d2, nil];
             }];

            id testObject =
                [config resolveComponent:@protocol(IDependsOnMultiple)];
            dependsMultiple = testObject;

            XCTAssertNotNil(testObject, "testObject is not nil.");
            XCTAssertTrue([testObject conformsToProtocol:
                           @protocol(IDependsOnMultiple)],
                          "testObject conforms to TestProtocol.");

            XCTAssertTrue([log getLines].count == 0, @"No delloc yet logged.");
        } // End of container scope

        XCTAssertTrue([log getLines].count == 0, @"No delloc yet logged.");
    } // End of outer scope

    NSArray* logLines = [log getLines];
    XCTAssertTrue(logLines.count == 2, @"Dealloc on 2 objects logged.");
    XCTAssertTrue([logLines containsObject:expected1]);
    XCTAssertTrue([logLines containsObject:expected2]);
}

- (void)testChildScopeResolvesParentRegistryPreResolved
{
    NSString* expected1 = @"dealloc in DescopeLoggerA";
    CCTCocoatainer* outerScope = [[CCTCocoatainer alloc] init];

    [outerScope registerComponent:@protocol(ILog)
                        initsWith:^{
                            return [[ArrayLog alloc] init];
                        }];

    id<ILog> log = [outerScope resolveComponent:@protocol(ILog)];
    XCTAssertNotNil(log, "log is not nil.");
    XCTAssertTrue([log conformsToProtocol:@protocol(ILog)],
                  "log conforms to TestProtocol.");

    @autoreleasepool
    {
        CCTCocoatainer* innerScope = [[CCTCocoatainer alloc] init];
        [innerScope addParent:outerScope];

        [innerScope registerComponent:@protocol(ILoggerA)
                         dependentOn1:@protocol(ILog)
                            initsWith:^(id<ILog> log){
                                return [[DescopeLoggerA alloc] initWithLog:log];
                            }];

        id testObject = [innerScope resolveComponent:@protocol(ILoggerA)];

        XCTAssertNotNil(testObject, "testObject is not nil.");
        XCTAssertTrue([testObject conformsToProtocol:@protocol(ILoggerA)],
                      "testObject conforms to TestProtocol.");

        XCTAssertTrue([log getLines].count == 0, @"No delloc yet logged.");
    } // End of inner scope

    NSArray* logLines = [log getLines];
    XCTAssertTrue(logLines.count == 1, @"Dealloc on 1 objects logged.");
    XCTAssertTrue([logLines containsObject:expected1]);
}

- (void)testChildScopeResolvesParentRegistryPreviouslyUnresolved
{
    NSString* expected1 = @"dealloc in DescopeLoggerA";
    CCTCocoatainer* outerScope = [[CCTCocoatainer alloc] init];

    [outerScope registerComponent:@protocol(ILog)
                        initsWith:^{
                            return [[ArrayLog alloc] init];
                        }];

    @autoreleasepool
    {
        CCTCocoatainer* innerScope = [[CCTCocoatainer alloc] init];
        [innerScope addParent:outerScope];

        [innerScope registerComponent:@protocol(ILoggerA)
                         dependentOn1:@protocol(ILog)
                            initsWith:^(id<ILog> log){
                                return [[DescopeLoggerA alloc] initWithLog:log];
                            }];

        id testObject = [innerScope resolveComponent:@protocol(ILoggerA)];

        XCTAssertNotNil(testObject, "testObject is not nil.");
        XCTAssertTrue([testObject conformsToProtocol:@protocol(ILoggerA)],
                      "testObject conforms to TestProtocol.");
    } // End of inner scope

    id<ILog> log = [outerScope resolveComponent:@protocol(ILog)];
    NSArray* logLines = [log getLines];
    XCTAssertTrue(logLines.count == 1, @"Dealloc on 1 objects logged.");
    XCTAssertTrue([logLines containsObject:expected1]);
}

- (void)testParentScopeResolveChildRegistryThrows
{
    CCTCocoatainer* outerScope = [[CCTCocoatainer alloc] init];

    [outerScope registerComponent:@protocol(ILog)
                        initsWith:^{
                            return [[ArrayLog alloc] init];
                        }];

    @autoreleasepool
    {
        CCTCocoatainer* innerScope = [[CCTCocoatainer alloc] init];
        [innerScope addParent:outerScope];

        [innerScope registerComponent:@protocol(ILoggerA)
                         dependentOn1:@protocol(ILog)
                            initsWith:^(id<ILog> log){
                                return [[DescopeLoggerA alloc] initWithLog:log];
                            }];

        XCTAssertThrows([outerScope resolveComponent:@protocol(ILoggerA)],
                        @"Parent cannot reach chile scope registry.");
    } // End of inner scope
}

- (void)testResolveDependenciesRegisteredOnThreeGenerationsOfScope
{
    CCTCocoatainer* outerScope = [[CCTCocoatainer alloc] init];

    [outerScope registerComponent:@protocol(ILog)
                        initsWith:^{
                            return [[ArrayLog alloc] init];
                        }];

    @autoreleasepool
    {
        CCTCocoatainer* middleScope = [[CCTCocoatainer alloc] init];
        [middleScope addParent:outerScope];

        [middleScope registerComponent:@protocol(ILoggerA)
                          dependentOn1:@protocol(ILog)
                             initsWith:^(id<ILog> log){
                                return [[DescopeLoggerA alloc] initWithLog:log];
                            }];

        @autoreleasepool
        {
            CCTCocoatainer* innerScope = [[CCTCocoatainer alloc] init];
            [innerScope addParent:middleScope];

            [middleScope registerComponent:@protocol(ILoggerB)
                              dependentOn1:@protocol(ILog)
                                 initsWith:^(id<ILog> log){
                                     return [[DescopeLoggerB alloc] initWithLog:log];
                                 }];

            [innerScope registerComponent:@protocol(IDependsOnMultiple)
                             dependentOn1:@protocol(ILoggerA)
                                     and2:@protocol(ILoggerB)
                                initsWith:
             ^(id<ILoggerA> d1, id<ILoggerB> d2){
                 return [[DependsOnMultiple alloc]
                         initWithDependencies:d1, d2, nil];
             }];

            id<IDependsOnMultiple> testObject =
                [innerScope resolveComponent:@protocol(IDependsOnMultiple)];

            XCTAssertNotNil(testObject, "testObject is not nil.");
            XCTAssertTrue([testObject conformsToProtocol:
                           @protocol(IDependsOnMultiple)],
                          "testObject conforms to TestProtocol.");
        } // End of inner scope
    } // End of middle scope
}

- (void)testDeallocationOfGrandchildAndParentScopes
{
    NSString* expected1 = @"dealloc in DescopeLoggerA";
    NSString* expected2 = @"dealloc in DescopeLoggerB";

    CCTCocoatainer* outerScope = [[CCTCocoatainer alloc] init];

    [outerScope registerComponent:@protocol(ILog)
                        initsWith:^{
                            return [[ArrayLog alloc] init];
                        }];

    id<ILog> log = [outerScope resolveComponent:@protocol(ILog)];

    @autoreleasepool
    {
        CCTCocoatainer* middleScope = [[CCTCocoatainer alloc] init];
        [middleScope addParent:outerScope];

        [middleScope registerComponent:@protocol(ILoggerA)
                          dependentOn1:@protocol(ILog)
                             initsWith:^(id<ILog> log){
                                 return [[DescopeLoggerA alloc] initWithLog:log];
                             }];

        NSArray* logLines0 = [log getLines];
        XCTAssertTrue(logLines0.count == 0, @"Dealloc on 0 objects logged.");

        @autoreleasepool
        {
            CCTCocoatainer* innerScope = [[CCTCocoatainer alloc] init];
            [innerScope addParent:middleScope];

            [middleScope registerComponent:@protocol(ILoggerB)
                              dependentOn1:@protocol(ILog)
                                 initsWith:^(id<ILog> log){
                                     return [[DescopeLoggerB alloc] initWithLog:log];
                                 }];

            [innerScope registerComponent:@protocol(IDependsOnMultiple)
                             dependentOn1:@protocol(ILoggerA)
                                     and2:@protocol(ILoggerB)
                                initsWith:
             ^(id<ILoggerA> d1, id<ILoggerB> d2){
                 return [[DependsOnMultiple alloc]
                         initWithDependencies:d1, d2, nil];
             }];

            id<IDependsOnMultiple> testObject =
            [innerScope resolveComponent:@protocol(IDependsOnMultiple)];

            XCTAssertNotNil(testObject, "testObject is not nil.");
            XCTAssertTrue([testObject conformsToProtocol:
                           @protocol(IDependsOnMultiple)],
                          "testObject conforms to TestProtocol.");
        } // End of inner scope

        NSArray* logLines1 = [log getLines];
        XCTAssertTrue(logLines1.count == 1, @"Dealloc on 1 objects logged.");
    } // End of middle scope

    NSArray* logLines2 = [log getLines];
    XCTAssertTrue(logLines2.count == 2, @"Dealloc on 2 objects logged.");
    XCTAssertTrue([logLines2 containsObject:expected1]);
    XCTAssertTrue([logLines2 containsObject:expected2]);
}

@end
