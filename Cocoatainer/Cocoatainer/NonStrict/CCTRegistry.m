//
//  CCTAbstractRegistry.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-15.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "CCTRegistry.h"

@interface CCTRegistry ()
{
@private
    NSMutableDictionary *_componentsMap;
}

@end

@implementation CCTRegistry

-(id)init
{
    self = [super init];
    if(self)
    {
        _componentsMap = [NSMutableDictionary dictionary];
    }
    return self;
}

-(CCTComponent*)getComponentRegistry:(NSString*)key
{
    return _componentsMap[key];
}

-(void)traverseAndExecute:(TraverseComponents)action
{
    for (NSString* key in _componentsMap)
    {
        CCTComponent* component = _componentsMap[key];
        action(component);
    }
}

-(void)addComponent:(Class)abstraction
       withInstance:(id)object
{
    [self addComponent:abstraction
      withDependencies:@[]
        andConstructor:nil
           andInstance:object];
}

-(void)addComponent:(Class)abstraction
   withDependencies:(NSArray*)dependencies
     andConstructor:(id)constructor
{
    [self addComponent:abstraction
      withDependencies:dependencies
        andConstructor:constructor
           andInstance:nil];
}

-(void)addComponent:(Class)abstraction
   withDependencies:(NSArray*)dependencies
     andConstructor:(id)constructor
        andInstance:(id)instance
{
    NSString *dependencyKey = NSStringFromClass(abstraction);

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
