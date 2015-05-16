//
//  CCTAbstractRegistry.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-15.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "CCTAbstractRegistry.h"

@interface CCTAbstractRegistry ()
{
@private
    NSMutableDictionary *_componentsMap;
}

@end

@implementation CCTAbstractRegistry

-(id)init
{
    self = [super init];
    if(self)
    {
        _componentsMap = [NSMutableDictionary dictionary];
    }
    return self;
}

-(CCTAbstractedComponent*)getComponentRegistry:(NSString*)key
{
    return _componentsMap[key];
}

-(void)traverseAndExecute:(TraverseComponents)action
{
    for (NSString* key in _componentsMap)
    {
        CCTAbstractedComponent* component = _componentsMap[key];
        action(component);
    }
}

-(void)addComponent:(Protocol*)abstraction
       withInstance:(id)object
{
    [self addComponent:abstraction
      withDependencies:@[]
        andConstructor:nil
           andInstance:object];
}

-(void)addComponent:(Protocol*)abstraction
   withDependencies:(NSArray*)dependencies
     andConstructor:(id)constructor
{
    [self addComponent:abstraction
      withDependencies:dependencies
        andConstructor:constructor
           andInstance:nil];
}

-(void)addComponent:(Protocol*)abstraction
   withDependencies:(NSArray*)dependencies
     andConstructor:(id)constructor
        andInstance:(id)instance
{
    NSString *dependencyKey = NSStringFromProtocol(abstraction);

    if (_componentsMap[dependencyKey])
    {
        return;
    }

    CCTAbstractedComponent* c = [[CCTAbstractedComponent alloc] init];
    c.abstracion = abstraction;
    c.instance = instance;
    c.constructor = constructor;
    c.dependencies = dependencies;
    [_componentsMap setObject:c forKey:dependencyKey];
}

@end
