//
//  AbstractStartableTests.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-16.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CCTAbstractCocoatainer.h"

#import "TestTypes/DependsOn2.h"
#import "TestTypes/StartupLogger.h"
#import "Logging/ArrayLog.h"
#import "Logging/ILogger.h"
#import "Logging/ILog.h"

@interface AbstractStartableTests : XCTestCase

@end

@implementation AbstractStartableTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStartableNoAutoResolve
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    id<ILog> log = [[ArrayLog alloc] init];
    [config registerComponent:@protocol(ILog)
                 withInstance:log];

    [config registerComponent:@protocol(ILoggerA)
                 dependentOn1:@protocol(ILog)
                    withBlock:
     ^(id<ILog> log){
         return [[StartupLoggerA alloc] initWithLog:log];
     }];

    [config registerComponent:@protocol(ILoggerB)
                 dependentOn1:@protocol(ILog)
                    withBlock:
     ^(id<ILog> log){
         return [[StartupLoggerB alloc] initWithLog:log];
     }];

    [config registerComponent:@protocol(IDependsOn2Startables)
                 dependentOn1:@protocol(ILoggerA)
                         and2:@protocol(ILoggerB)
                    withBlock:^(id<ILoggerA> d1, id<ILoggerB> d2)
     {
         return [[DependsOn2Startables alloc] initWithD1:d1 and2:d2];
     }];

    [config start:NO];

    NSArray* startupLog = [log getLines];
    XCTAssertTrue([startupLog count] == 0, "startupLog is empty.");
}

- (void)testStartableAutoResolve
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    NSString* expected1 = NSStringFromClass([StartupLoggerA class]);
    NSString* expected2 = NSStringFromClass([StartupLoggerB class]);

    id<ILog> log = [[ArrayLog alloc] init];
    [config registerComponent:@protocol(ILog)
                 withInstance:log];

    [config registerComponent:@protocol(ILoggerA)
                 dependentOn1:@protocol(ILog)
                    withBlock:
     ^(id<ILog> log){
         return [[StartupLoggerA alloc] initWithLog:log];
     }];

    [config registerComponent:@protocol(ILoggerB)
                 dependentOn1:@protocol(ILog)
                    withBlock:
     ^(id<ILog> log){
         return [[StartupLoggerB alloc] initWithLog:log];
     }];

    [config registerComponent:@protocol(IDependsOn2Startables)
                 dependentOn1:@protocol(ILoggerA)
                         and2:@protocol(ILoggerB)
                    withBlock:^(id<ILoggerA> d1, id<ILoggerB> d2)
     {
         return [[DependsOn2Startables alloc] initWithD1:d1 and2:d2];
     }];

    [config start:YES];

    NSArray* startupLog = [log getLines];
    XCTAssertTrue([startupLog containsObject:expected1]);
    XCTAssertTrue([startupLog containsObject:expected2]);
}

- (void)testStartableResolveOrder1
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    NSString* expected1 = NSStringFromClass([StartupLoggerA class]);
    NSString* expected2 = NSStringFromClass([StartupLoggerB class]);

    id<ILog> log = [[ArrayLog alloc] init];
    [config registerComponent:@protocol(ILog)
                 withInstance:log];

    [config registerComponent:@protocol(ILoggerA)
                 dependentOn1:@protocol(ILog)
                    withBlock:
     ^(id<ILog> log){
         return [[StartupLoggerA alloc] initWithLog:log];
     }];

    [config registerComponent:@protocol(ILoggerB)
                 dependentOn1:@protocol(ILog)
                    withBlock:
     ^(id<ILog> log){
         return [[StartupLoggerB alloc] initWithLog:log];
     }];

    [config registerComponent:@protocol(IDependsOn2Startables)
                 dependentOn1:@protocol(ILoggerA)
                         and2:@protocol(ILoggerB)
                    withBlock:^(id<ILoggerA> d1, id<ILoggerB> d2)
     {
         return [[DependsOn2Startables alloc] initWithD1:d1 and2:d2];
     }];

    id testObject = [config resolveComponent:@protocol(IDependsOn2Startables)];
    [config start:NO];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOn2Startables)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] conformsToProtocol:@protocol(ILoggerA)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] conformsToProtocol:@protocol(ILoggerB)],
                  "testObject conforms to TestProtocol.");

    NSArray* startupLog = [log getLines];
    NSString* actual1 = startupLog[0];
    NSString* actual2 = startupLog[1];

    XCTAssertTrue([actual1 isEqualToString:expected1],
                  "First startup logged class.");
    XCTAssertTrue([actual2 isEqualToString:expected2],
                  "Second startup logged class.");
}

- (void)testStartableResolveOrder2
{
    CCTAbstractCocoatainer* config = [[CCTAbstractCocoatainer alloc] init];

    NSString* expected1 = NSStringFromClass([StartupLoggerB class]);
    NSString* expected2 = NSStringFromClass([StartupLoggerA class]);

    id<ILog> log = [[ArrayLog alloc] init];
    [config registerComponent:@protocol(ILog)
                 withInstance:log];

    [config registerComponent:@protocol(ILoggerA)
                 dependentOn1:@protocol(ILog)
                    withBlock:
     ^(id<ILog> log){
         return [[StartupLoggerA alloc] initWithLog:log];
     }];

    [config registerComponent:@protocol(ILoggerB)
                 dependentOn1:@protocol(ILog)
                    withBlock:
     ^(id<ILog> log){
         return [[StartupLoggerB alloc] initWithLog:log];
     }];

    [config registerComponent:@protocol(IDependsOn2Startables)
                 dependentOn1:@protocol(ILoggerB)
                         and2:@protocol(ILoggerA)
                    withBlock:^(id<ILoggerB> d1, id<ILoggerA> d2)
     {
         return [[DependsOn2Startables alloc] initWithD1:d2 and2:d1];
     }];

    id testObject = [config resolveComponent:@protocol(IDependsOn2Startables)];
    [config start:NO];

    XCTAssertNotNil(testObject, "testObject is not nil.");
    XCTAssertTrue([testObject conformsToProtocol:@protocol(IDependsOn2Startables)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency1], "Dependency 1 is not nil.");
    XCTAssertTrue([[testObject dependency1] conformsToProtocol:@protocol(ILoggerA)],
                  "testObject conforms to TestProtocol.");

    XCTAssertNotNil([testObject dependency2], "Dependency 2 is not nil.");
    XCTAssertTrue([[testObject dependency2] conformsToProtocol:@protocol(ILoggerB)],
                  "testObject conforms to TestProtocol.");

    NSArray* startupLog = [log getLines];
    NSString* actual1 = startupLog[0];
    NSString* actual2 = startupLog[1];

    // TODO: ordering broken in container in the last few commits.
    // Must fix resolution ordering to pass these tests.
    XCTAssertTrue([actual1 isEqualToString:expected1],
                  "First startup logged class.");
    XCTAssertTrue([actual2 isEqualToString:expected2],
                  "Second startup logged class.");
}

@end
