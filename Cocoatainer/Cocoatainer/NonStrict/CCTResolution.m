//
//  CCTResolution.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-14.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import "CCTResolution.h"
#import "CCTComponent.h"
#import "CCTInitializers.h"
#import "NSObject+TypeDeduction.h"

@implementation CCTResolution

+(id)resolveComponent:(id)abstraction
              fromMap:(CCTRegistry*)registry
{
    NSString *componentKey = [abstraction isConcrete] ?
        NSStringFromClass(abstraction) : NSStringFromProtocol(abstraction);

    CCTComponent* c = [registry getComponentRegistry:componentKey];
    id resolvedInstance = c.instance;
    if (resolvedInstance)
    {
        return resolvedInstance;
    }

    id initializer = c.constructor;

    if (!initializer)
    {
        return nil;
    }

    resolvedInstance = [self resolveDependenciesFor:c
                                            fromMap:registry
                                         usingBlock:initializer];

    c.instance = resolvedInstance;

    return resolvedInstance;
}

+(id)resolveDependenciesFor:(CCTComponent*)component
                    fromMap:(CCTRegistry*)registry
                 usingBlock:(id)block
{
    NSArray* dependencies = component.dependencies;

    if (component.initWithDepsArray)
    {
        return [self resolveArrayDependencies:dependencies
                                      fromMap:registry
                                   usingBlock:block];
    }

    return [self resolveFixedDependencies:dependencies
                                  fromMap:registry
                               usingBlock:block];
}

+(id)resolveArrayDependencies:(NSArray*)dependencies
                      fromMap:(CCTRegistry*)registry
                   usingBlock:(id)block
{
    NSMutableArray* depInstances =
        [NSMutableArray arrayWithCapacity:dependencies.count];

    for (id dep in dependencies)
    {
        id instance = [self resolveComponent:dep fromMap:registry];
        [depInstances addObject:instance];
    }
    return ((Initializer)block)(depInstances);
}

+(id)resolveFixedDependencies:(NSArray*)dependencies
                      fromMap:(CCTRegistry*)registry
                   usingBlock:(id)block
{
    switch (dependencies.count)
    {
        case 0:
        {
            return ((Initializer0)block)();
        }
        case 1:
        {
            id depInstance0 =
                [self resolveComponent:dependencies[0] fromMap:registry];
            return ((Initializer1)block)(depInstance0);
        }
        case 2:
        {
            id depInstance0 =
                [self resolveComponent:dependencies[0] fromMap:registry];
            id depInstance1 =
                [self resolveComponent:dependencies[1] fromMap:registry];
            return ((Initializer2)block)(depInstance0,
                                         depInstance1);
        }
        case 3:
        {
            id depInstance0 =
                [self resolveComponent:dependencies[0] fromMap:registry];
            id depInstance1 =
                [self resolveComponent:dependencies[1] fromMap:registry];
            id depInstance2 =
                [self resolveComponent:dependencies[2] fromMap:registry];
            return ((Initializer3)block)(depInstance0,
                                         depInstance1,
                                         depInstance2);
        }
        case 4:
        {
            id depInstance0 =
                [self resolveComponent:dependencies[0] fromMap:registry];
            id depInstance1 =
                [self resolveComponent:dependencies[1] fromMap:registry];
            id depInstance2 =
                [self resolveComponent:dependencies[2] fromMap:registry];
            id depInstance3 =
                [self resolveComponent:dependencies[3] fromMap:registry];
            return ((Initializer4)block)(depInstance0,
                                         depInstance1,
                                         depInstance2,
                                         depInstance3);
        }
        case 5:
        {
            id depInstance0 =
                [self resolveComponent:dependencies[0] fromMap:registry];
            id depInstance1 =
                [self resolveComponent:dependencies[1] fromMap:registry];
            id depInstance2 =
                [self resolveComponent:dependencies[2] fromMap:registry];
            id depInstance3 =
                [self resolveComponent:dependencies[3] fromMap:registry];
            id depInstance4 =
                [self resolveComponent:dependencies[4] fromMap:registry];
            return ((Initializer5)block)(depInstance0,
                                         depInstance1,
                                         depInstance2,
                                         depInstance3,
                                         depInstance4);
        }
        case 6:
        {
            id depInstance0 =
                [self resolveComponent:dependencies[0] fromMap:registry];
            id depInstance1 =
                [self resolveComponent:dependencies[1] fromMap:registry];
            id depInstance2 =
                [self resolveComponent:dependencies[2] fromMap:registry];
            id depInstance3 =
                [self resolveComponent:dependencies[3] fromMap:registry];
            id depInstance4 =
                [self resolveComponent:dependencies[4] fromMap:registry];
            id depInstance5 =
                [self resolveComponent:dependencies[5] fromMap:registry];
            return ((Initializer6)block)(depInstance0,
                                         depInstance1,
                                         depInstance2,
                                         depInstance3,
                                         depInstance4,
                                         depInstance5);
        }
        case 7:
        {
            id depInstance0 =
                [self resolveComponent:dependencies[0] fromMap:registry];
            id depInstance1 =
                [self resolveComponent:dependencies[1] fromMap:registry];
            id depInstance2 =
                [self resolveComponent:dependencies[2] fromMap:registry];
            id depInstance3 =
                [self resolveComponent:dependencies[3] fromMap:registry];
            id depInstance4 =
                [self resolveComponent:dependencies[4] fromMap:registry];
            id depInstance5 =
                [self resolveComponent:dependencies[5] fromMap:registry];
            id depInstance6 =
                [self resolveComponent:dependencies[6] fromMap:registry];
            return ((Initializer7)block)(depInstance0,
                                         depInstance1,
                                         depInstance2,
                                         depInstance3,
                                         depInstance4,
                                         depInstance5,
                                         depInstance6);
        }
        case 8:
        {
            id depInstance0 =
                [self resolveComponent:dependencies[0] fromMap:registry];
            id depInstance1 =
                [self resolveComponent:dependencies[1] fromMap:registry];
            id depInstance2 =
                [self resolveComponent:dependencies[2] fromMap:registry];
            id depInstance3 =
                [self resolveComponent:dependencies[3] fromMap:registry];
            id depInstance4 =
                [self resolveComponent:dependencies[4] fromMap:registry];
            id depInstance5 =
                [self resolveComponent:dependencies[5] fromMap:registry];
            id depInstance6 =
                [self resolveComponent:dependencies[6] fromMap:registry];
            id depInstance7 =
                [self resolveComponent:dependencies[7] fromMap:registry];
            return ((Initializer8)block)(depInstance0,
                                         depInstance1,
                                         depInstance2,
                                         depInstance3,
                                         depInstance4,
                                         depInstance5,
                                         depInstance6,
                                         depInstance7);
        }
    }
    return nil;
}

@end
