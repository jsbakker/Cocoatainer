//
//  CCTAbstractCocoatainer.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "CCTAbstractCocoatainer.h"
#import "CCTAbstractedComponent.h"
#import "CCTAbstractResolution.h"
#import "CCTAbstractRegistry.h"
#import "CCTStartable.h"

@interface CCTAbstractCocoatainer ()
{
@private
    CCTAbstractRegistry* _model;
}

-(void)resolveAll;

@end

@implementation CCTAbstractCocoatainer

-(id)init
{
    self = [super init];
    if(self)
    {
        _model = [[CCTAbstractRegistry alloc] init];
    }
    return self;
}

-(void)start:(BOOL)autoResolve
{
    if (autoResolve)
    {
        [self resolveAll];
    }

    [_model traverseAndExecute:^(CCTAbstractedComponent* c)
     {
         id instance = c.instance;
         if ([instance conformsToProtocol:@protocol(CCTStartable)])
         {
             [instance start];
         }
     }];
}

-(void)registerComponent:(Protocol*)abstraction withInstance:(id)object
{
    [_model addComponent:abstraction withInstance:object];
}

-(void)registerComponent:(Protocol*)abstraction
               withBlock:(CreationBlock0)block
{
    [_model addComponent:abstraction withDependencies:@[] andConstructor:block];
}

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
               withBlock:(CreationBlock1)block
{
    NSArray* dependencies = @[NSStringFromProtocol(d1)];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
                    and2:(Protocol*)d2
               withBlock:(CreationBlock2)block
{
    NSArray* dependencies = @[NSStringFromProtocol(d1),
                              NSStringFromProtocol(d2)];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
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
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
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
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
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
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
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
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(id)resolveComponent:(Protocol*)abstraction
{
    return
        [CCTAbstractResolution resolveComponent:abstraction fromMap:_model];
}

-(void)resolveAll
{
    [_model traverseAndExecute:^(CCTAbstractedComponent* c)
     {
         if (!c.instance)
         {
             [self resolveComponent:c.abstracion];
         }
     }];
}

@end
