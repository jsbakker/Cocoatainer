//
//  CocoatainerConfiguration.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "CCTCocoatainerConfiguration.h"

@interface CCTCocoatainerConfiguration ()
{
@private
    NSMutableDictionary *_abstractionInstanceMap;
    NSMutableDictionary *_instantiationBlockMap;
    NSMutableDictionary *_instanceDependencies;
}

-(void)registerDependencies:(NSArray*)dependencies
                     forKey:(Protocol*)abstraction
                  withBlock:(id)block;

-(id)resolveDependencies:(NSArray*)dependencies usingBlock:(id)block;

@end

@implementation CCTCocoatainerConfiguration

-(id)init
{
    self = [super init];
    if(self)
    {
        _abstractionInstanceMap = [NSMutableDictionary dictionary];
        _instantiationBlockMap = [NSMutableDictionary dictionary];
        _instanceDependencies = [NSMutableDictionary dictionary];
    }
    
    return self;
}

-(void)registerComponent:(Protocol*)abstraction withInstance:(id)object
{
    NSString *dependencyKey = NSStringFromProtocol(abstraction);
    [_abstractionInstanceMap setObject:object forKey:dependencyKey];
}

-(void)registerComponent:(Protocol*)abstraction
               withBlock:(CreationBlock0)block
{
    NSString *dependencyKey = NSStringFromProtocol(abstraction);

    if (_instantiationBlockMap[dependencyKey])
    {
        return;
    }
    [_instantiationBlockMap setObject:block forKey:dependencyKey];
}

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
               withBlock:(CreationBlock1)block
{
    NSArray* dependencies = @[NSStringFromProtocol(d1)];
    [self registerDependencies:dependencies forKey:abstraction withBlock:block];
}

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
                    and2:(Protocol*)d2
               withBlock:(CreationBlock2)block
{
    NSArray* dependencies = @[NSStringFromProtocol(d1),
                              NSStringFromProtocol(d2)];
    [self registerDependencies:dependencies forKey:abstraction withBlock:block];
}

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
                    and2:(Protocol*)d2
                    and3:(Protocol*)d3
               withBlock:(CreationBlock3)block
{
    NSArray* dependencies = @[NSStringFromProtocol(d1),
                              NSStringFromProtocol(d2),
                              NSStringFromProtocol(d3)];
    [self registerDependencies:dependencies forKey:abstraction withBlock:block];
}

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
                    and2:(Protocol*)d2
                    and3:(Protocol*)d3
                    and4:(Protocol*)d4
               withBlock:(CreationBlock4)block
{
    NSArray* dependencies = @[NSStringFromProtocol(d1),
                              NSStringFromProtocol(d2),
                              NSStringFromProtocol(d3),
                              NSStringFromProtocol(d4)];
    [self registerDependencies:dependencies forKey:abstraction withBlock:block];
}

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
                    and2:(Protocol*)d2
                    and3:(Protocol*)d3
                    and4:(Protocol*)d4
                    and5:(Protocol*)d5
               withBlock:(CreationBlock5)block
{
    NSArray* dependencies = @[NSStringFromProtocol(d1),
                              NSStringFromProtocol(d2),
                              NSStringFromProtocol(d3),
                              NSStringFromProtocol(d4),
                              NSStringFromProtocol(d5)];
    [self registerDependencies:dependencies forKey:abstraction withBlock:block];
}

-(id)resolveComponent:(Protocol*)abstraction
{
    NSString *dependencyKey = NSStringFromProtocol(abstraction);

    id resolvedInstance = _abstractionInstanceMap[dependencyKey];
    if (resolvedInstance)
    {
        return resolvedInstance;
    }

    id creationBlock = _instantiationBlockMap[dependencyKey];

    if (!creationBlock)
    {
        return nil;
    }

    NSArray* dependencies = (NSArray*)_instanceDependencies[dependencyKey];
    resolvedInstance =
        [self resolveDependencies:dependencies usingBlock:creationBlock];

    [_abstractionInstanceMap setObject:resolvedInstance forKey:dependencyKey];

    return resolvedInstance;
}

-(void)registerDependencies:(NSArray*)dependencies
                     forKey:(Protocol*)abstraction
                  withBlock:(id)block
{
    NSString *dependencyKey = NSStringFromProtocol(abstraction);

    if (_instantiationBlockMap[dependencyKey])
    {
        return;
    }
    [_instantiationBlockMap setObject:block forKey:dependencyKey];
    [_instanceDependencies setObject:dependencies forKey:dependencyKey];
}

-(id)resolveDependencies:(NSArray*)dependencies usingBlock:(id)block
{
    switch (dependencies.count)
    {
        case 0:
        {
            return ((CreationBlock0)block)();
        }
        case 1:
        {
            id depInstance0 =
            [self resolveComponent:NSProtocolFromString(dependencies[0])];
            return ((CreationBlock1)block)(depInstance0);
        }
        case 2:
        {
            id depInstance0 =
            [self resolveComponent:NSProtocolFromString(dependencies[0])];
            id depInstance1 =
            [self resolveComponent:NSProtocolFromString(dependencies[1])];
            return ((CreationBlock2)block)(depInstance0,
                                           depInstance1);
        }
        case 3:
        {
            id depInstance0 =
            [self resolveComponent:NSProtocolFromString(dependencies[0])];
            id depInstance1 =
            [self resolveComponent:NSProtocolFromString(dependencies[1])];
            id depInstance2 =
            [self resolveComponent:NSProtocolFromString(dependencies[2])];
            return ((CreationBlock3)block)(depInstance0,
                                           depInstance1,
                                           depInstance2);
        }
        case 4:
        {
            id depInstance0 =
            [self resolveComponent:NSProtocolFromString(dependencies[0])];
            id depInstance1 =
            [self resolveComponent:NSProtocolFromString(dependencies[1])];
            id depInstance2 =
            [self resolveComponent:NSProtocolFromString(dependencies[2])];
            id depInstance3 =
            [self resolveComponent:NSProtocolFromString(dependencies[3])];
            return ((CreationBlock4)block)(depInstance0,
                                           depInstance1,
                                           depInstance2,
                                           depInstance3);
        }
        case 5:
        {
            id depInstance0 =
            [self resolveComponent:NSProtocolFromString(dependencies[0])];
            id depInstance1 =
            [self resolveComponent:NSProtocolFromString(dependencies[1])];
            id depInstance2 =
            [self resolveComponent:NSProtocolFromString(dependencies[2])];
            id depInstance3 =
            [self resolveComponent:NSProtocolFromString(dependencies[3])];
            id depInstance4 =
            [self resolveComponent:NSProtocolFromString(dependencies[4])];
            return ((CreationBlock5)block)(depInstance0,
                                           depInstance1,
                                           depInstance2,
                                           depInstance3,
                                           depInstance4);
        }
    }
    return nil;
}
@end
