//
//  CCTCocoatainer.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "CCTCocoatainer.h"
#import "CCTComponent.h"
#import "CCTResolution.h"
#import "CCTRegistry.h"
#import "CCTStartable.h"

@interface CCTCocoatainer ()
{
@private
    CCTRegistry* _model;
}

-(void)resolveAll;

@end

@implementation CCTCocoatainer

-(id)init
{
    self = [super init];
    if(self)
    {
        _model = [[CCTRegistry alloc] init];
    }
    return self;
}

-(void)start:(BOOL)autoResolve
{
    if (autoResolve)
    {
        [self resolveAll];
    }

    [_model traverseAndExecute:^(CCTComponent* c)
     {
         id instance = c.instance;
         if ([instance conformsToProtocol:@protocol(CCTStartable)])
         {
             [instance start];
         }
     }];
}

-(void)registerComponent:(Class)abstraction withInstance:(id)object
{
    [_model addComponent:abstraction withInstance:object];
}

-(void)registerComponent:(Class)abstraction
               withBlock:(CreationBlock0)block
{
    [_model addComponent:abstraction withDependencies:@[] andConstructor:block];
}

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
               withBlock:(CreationBlock1)block
{
    NSArray* dependencies = @[NSStringFromClass(d1)];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
                    and2:(Class)d2
               withBlock:(CreationBlock2)block
{
    NSArray* dependencies = @[NSStringFromClass(d1),
                              NSStringFromClass(d2)];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
                    and2:(Class)d2
                    and3:(Class)d3
               withBlock:(CreationBlock3)block
{
    NSArray* dependencies = @[NSStringFromClass(d1),
                              NSStringFromClass(d2),
                              NSStringFromClass(d3)];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
                    and2:(Class)d2
                    and3:(Class)d3
                    and4:(Class)d4
               withBlock:(CreationBlock4)block
{
    NSArray* dependencies = @[NSStringFromClass(d1),
                              NSStringFromClass(d2),
                              NSStringFromClass(d3),
                              NSStringFromClass(d4)];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
                    and2:(Class)d2
                    and3:(Class)d3
                    and4:(Class)d4
                    and5:(Class)d5
               withBlock:(CreationBlock5)block
{
    NSArray* dependencies = @[NSStringFromClass(d1),
                              NSStringFromClass(d2),
                              NSStringFromClass(d3),
                              NSStringFromClass(d4),
                              NSStringFromClass(d5)];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
                    and2:(Class)d2
                    and3:(Class)d3
                    and4:(Class)d4
                    and5:(Class)d5
                    and6:(Class)d6
               withBlock:(CreationBlock6)block
{
    NSArray* dependencies = @[NSStringFromClass(d1),
                              NSStringFromClass(d2),
                              NSStringFromClass(d3),
                              NSStringFromClass(d4),
                              NSStringFromClass(d5),
                              NSStringFromClass(d6)];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(id)resolveComponent:(Class)abstraction
{
    return
        [CCTResolution resolveComponent:abstraction fromMap:_model];
}

-(void)resolveAll
{
    [_model traverseAndExecute:^(CCTComponent* c)
     {
         if (!c.instance)
         {
             [self resolveComponent:c.abstracion];
         }
     }];
}

@end
