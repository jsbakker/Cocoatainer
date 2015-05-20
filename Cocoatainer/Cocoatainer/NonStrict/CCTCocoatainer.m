//
//  CCTCocoatainer.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import "CCTCocoatainer.h"
#import "CCTComponent.h"
#import "CCTResolution.h"
#import "CCTRegistry.h"
#import "CCTStartable.h"

#import "NSObject+TypeDeduction.h"

@interface CCTCocoatainer ()
{
@protected
    CCTRegistry* _model;
    CCTCocoatainer* _parent;
}

-(void)typeCheck:(id)type;

-(void)registerDependencies:(NSArray*)dependencies
             forAbstraction:(id)abstraction
             withInitilizer:(id)initializer;

-(CCTRegistry*)getModel;
-(void)resolveAll;
-(void)setAbstract;
@end

@implementation CCTCocoatainer

-(id)init
{
    self = [super init];
    if(self)
    {
        _model = [[CCTRegistry alloc] init];
        _parent = nil;
    }
    return self;
}

-(void)dealloc
{
    _model = nil;
    _parent = nil;
}

-(void)addParent:(CCTCocoatainer*)parent
{
    _parent = parent;
    [_model addParent:[parent getModel]];
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
    [self typeCheck:abstraction];
    [_model addComponent:abstraction withInstance:object];
}

-(void)registerComponent:(id)abstraction
               initsWith:(Initializer0)block
{
    [self typeCheck:abstraction];
    [self registerDependencies:@[]
                forAbstraction:abstraction
                withInitilizer:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
               initsWith:(Initializer1)block
{
    NSArray* dependencies = @[d1];
    [self registerDependencies:dependencies
                forAbstraction:abstraction
                withInitilizer:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
               initsWith:(Initializer2)block
{
    NSArray* dependencies = @[d1, d2];
    [self registerDependencies:dependencies
                forAbstraction:abstraction
                withInitilizer:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
               initsWith:(Initializer3)block
{
    NSArray* dependencies = @[d1, d2, d3];
    [self registerDependencies:dependencies
                forAbstraction:abstraction
                withInitilizer:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
               initsWith:(Initializer4)block
{
    NSArray* dependencies = @[d1, d2, d3, d4];
    [self registerDependencies:dependencies
                forAbstraction:abstraction
                withInitilizer:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
               initsWith:(Initializer5)block
{
    NSArray* dependencies = @[d1, d2, d3, d4, d5];
    [self registerDependencies:dependencies
                forAbstraction:abstraction
                withInitilizer:block];
}

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
                    and6:(id)d6
               initsWith:(Initializer6)block
{
    NSArray* dependencies = @[d1, d2, d3, d4, d5, d6];
    [self registerDependencies:dependencies
                forAbstraction:abstraction
                withInitilizer:block];
}

-(void)registerComponent:(id)abstraction
             dependentOn:(NSArray*)dependencies
               initsWith:(Initializer)block
{
    [self registerDependencies:dependencies
                forAbstraction:abstraction
                withInitilizer:block];
}

-(id)resolveComponent:(id)abstraction
{
    id instance = [CCTResolution resolveComponent:abstraction fromMap:_model];
    if (instance)
    {
        return instance;
    }

    if (_parent)
    {
        instance = [_parent resolveComponent:abstraction];
    }

    if (instance)
    {
        return instance;
    }

    [NSException raise:NSInvalidArgumentException
                format:@"Cannot resolve unregistered component."];

    return nil;
}

-(void)typeCheck:(id)type
{
    if (!type || ([type isConcrete] && [type isInstance]))
    {
        [NSException raise:NSInvalidArgumentException
                    format:@"Must be a protocol or class."];
    }
}

-(void)registerDependencies:(NSArray*)dependencies
             forAbstraction:(id)abstraction
             withInitilizer:(id)initializer

{
    [self typeCheck:abstraction];
    for (id dep in dependencies)
    {
        [self typeCheck:dep];

        if (dep == abstraction)
        {
            [NSException raise:NSInvalidArgumentException
                        format:@"Dependency cannot be same type as component."];
        }
    }

    [_model addComponent:abstraction
        withDependencies:dependencies
          andConstructor:initializer];
}

-(CCTRegistry*)getModel
{
    return _model;
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

-(void)setAbstract
{
    _model.strict = YES;
}

-(void)registerContract:(Protocol*)abstraction
              initsWith:(Initializer0)block
{
    [self registerComponent:abstraction initsWith:block];
}

@end
