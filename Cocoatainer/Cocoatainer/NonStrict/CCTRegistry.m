//
//  CCTRegistry.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-15.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import "CCTRegistry.h"
#import "NSObject+TypeDeduction.h"

@interface CCTRegistry ()
{
@private
    NSMutableDictionary *_componentsMap;
    CCTRegistry* _parent;
}

@end

@implementation CCTRegistry

-(id)init
{
    self = [super init];
    if(self)
    {
        _componentsMap = [NSMutableDictionary dictionary];
        _parent = nil;
    }
    return self;
}

-(void)dealloc
{
    [_componentsMap removeAllObjects];
    _componentsMap = nil;
    _parent = nil;
}

-(void)addParent:(CCTRegistry*)parent
{
    _parent = parent;
}

-(CCTComponent*)getComponentRegistry:(NSString*)key
{
    CCTComponent* component = _componentsMap[key];
    if (component)
    {
        return component;
    }
    return [_parent getComponentRegistry:key];
}

-(void)traverseAndExecute:(TraverseComponents)action
{
    for (NSString* key in _componentsMap)
    {
        CCTComponent* component = _componentsMap[key];
        action(component);
    }
}

-(void)addComponent:(id)abstraction
       withInstance:(id)object
{
    [self addComponent:abstraction
      withDependencies:@[]
        andConstructor:nil
           andInstance:object];
}

-(void)addComponent:(id)abstraction
   withDependencies:(NSArray*)dependencies
     andConstructor:(id)constructor
{
    [self addComponent:abstraction
      withDependencies:dependencies
        andConstructor:constructor
           andInstance:nil];
}

-(void)addComponent:(id)abstraction
   withDependencies:(NSArray*)dependencies
     andConstructor:(id)constructor
        andInstance:(id)instance
{
    if (self.strict && [abstraction isConcrete])
    {
        [NSException raise:NSInvalidArgumentException
                    format:@"Cannot register concrete types in abstract mode."];
    }

    NSString *dependencyKey = [abstraction isConcrete] ?
        NSStringFromClass(abstraction) : NSStringFromProtocol(abstraction);

    if (_componentsMap[dependencyKey])
    {
        return;
    }

    CCTComponent* c = [[CCTComponent alloc] init];
    c.abstracion = abstraction;
    c.instance = instance;
    c.constructor = constructor;
    c.dependencies = dependencies;
    [_componentsMap setObject:c forKey:dependencyKey];
}

@end
