//
//  CCTCocoatainer.m
//  Cocoatainer
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
@protected
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

-(void)registerComponent:(id)abstraction withInstance:(id)object
{
    [_model addComponent:abstraction withInstance:object];
}

-(void)registerComponent:(id)abstraction
               withBlock:(CreationBlock0)block
{
    [_model addComponent:abstraction withDependencies:@[] andConstructor:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
               withBlock:(CreationBlock1)block
{
    NSArray* dependencies = @[d1];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
               withBlock:(CreationBlock2)block
{
    NSArray* dependencies = @[d1, d2];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
               withBlock:(CreationBlock3)block
{
    NSArray* dependencies = @[d1, d2, d3];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
               withBlock:(CreationBlock4)block
{
    NSArray* dependencies = @[d1, d2, d3, d4];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
               withBlock:(CreationBlock5)block
{
    NSArray* dependencies = @[d1, d2, d3, d4, d5];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
                    and6:(id)d6
               withBlock:(CreationBlock6)block
{
    NSArray* dependencies = @[d1, d2, d3, d4, d5, d6];
    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:block];
}

-(id)resolveComponent:(id)abstraction
{
    id instance = [CCTResolution resolveComponent:abstraction fromMap:_model];

    if (instance == nil)
    {
        [NSException raise:NSInvalidArgumentException
                    format:@"Cannot resolve unregistered component."];
    }
    return instance;
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
