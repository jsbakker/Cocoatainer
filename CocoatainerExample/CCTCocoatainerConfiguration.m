//
//  CocoatainerConfiguration.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "CCTCocoatainerConfiguration.h"
#import "CCTAbstractedComponent.h"
#import "CCTAbstractResolution.h"
#import "CCTStartable.h"

@interface CCTCocoatainerConfiguration ()
{
@private
    NSMutableDictionary *_componentsMap;
}

-(void)resolveAll;

-(void)registerDependencies:(NSArray*)dependencies
                     forKey:(Protocol*)abstraction
                  withBlock:(id)block;

@end

@implementation CCTCocoatainerConfiguration

-(id)init
{
    self = [super init];
    if(self)
    {
        _componentsMap = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)start:(BOOL)autoResolve
{
    if (autoResolve)
    {
        [self resolveAll];
    }

    for (NSString* key in _componentsMap)
    {
        CCTAbstractedComponent* component = _componentsMap[key];
        id instance = component.instance;
        if ([instance conformsToProtocol:@protocol(CCTStartable)])
        {
            [instance start];
        }
    }
}

-(void)registerComponent:(Protocol*)abstraction withInstance:(id)object
{
    NSString *dependencyKey = NSStringFromProtocol(abstraction);
    CCTAbstractedComponent* c = [[CCTAbstractedComponent alloc] init];
    c.abstracion = abstraction;
    c.instance = object;
    c.constructor = nil;
    c.dependencies = @[];
    [_componentsMap setObject:c forKey:dependencyKey];
}

-(void)registerComponent:(Protocol*)abstraction
               withBlock:(CreationBlock0)block
{
    [self registerDependencies:@[] forKey:abstraction withBlock:block];
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

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
                    and2:(Protocol*)d2
                    and3:(Protocol*)d3
                    and4:(Protocol*)d4
                    and5:(Protocol*)d5
                    and6:(Protocol*)d6
               withBlock:(CreationBlock6)block
{
    NSArray* dependencies = @[NSStringFromProtocol(d1),
                              NSStringFromProtocol(d2),
                              NSStringFromProtocol(d3),
                              NSStringFromProtocol(d4),
                              NSStringFromProtocol(d5),
                              NSStringFromProtocol(d6)];
    [self registerDependencies:dependencies forKey:abstraction withBlock:block];
}

-(id)resolveComponent:(Protocol*)abstraction
{
    return
        [CCTAbstractResolution resolveComponent:abstraction
                                        fromMap:_componentsMap];
}

-(void)resolveAll
{
    for (NSString* key in _componentsMap)
    {
        CCTAbstractedComponent* c = _componentsMap[key];
        if (!c.instance)
        {
            [self resolveComponent:NSProtocolFromString(key)];
        }
    }
}

-(void)registerDependencies:(NSArray*)dependencies
                     forKey:(Protocol*)abstraction
                  withBlock:(id)block
{
    NSString *dependencyKey = NSStringFromProtocol(abstraction);

    if (_componentsMap[dependencyKey])
    {
        return;
    }

    CCTAbstractedComponent* c = [[CCTAbstractedComponent alloc] init];
    c.abstracion = abstraction;
    c.constructor = block;
    c.dependencies = dependencies;
    [_componentsMap setObject:c forKey:dependencyKey];
}

@end
