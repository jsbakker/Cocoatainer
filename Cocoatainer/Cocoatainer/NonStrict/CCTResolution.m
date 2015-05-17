//
//  CCTAbstractResolution.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-14.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "CCTResolution.h"
#import "CCTComponent.h"
#import "CCTInitializers.h"
#import "NSObject+TypeDeduction.h"

@implementation CCTResolution

+(id)resolveComponent:(id)abstraction
              fromMap:(CCTRegistry*)registry
{
    NSString *dependencyKey = [abstraction isConcrete] ?
        NSStringFromClass(abstraction) : NSStringFromProtocol(abstraction);

    CCTComponent* c = [registry getComponentRegistry:dependencyKey];
    id resolvedInstance = c.instance;
    if (resolvedInstance)
    {
        return resolvedInstance;
    }

    id creationBlock = c.constructor;

    if (!creationBlock)
    {
        return nil;
    }

    NSArray* dependencies = c.dependencies;
    resolvedInstance =
    [self resolveDependencies:dependencies
                      fromMap:registry
                   usingBlock:creationBlock];

    c.instance = resolvedInstance;

    return resolvedInstance;
}

+(id)resolveDependencies:(NSArray*)dependencies
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
    }
    return nil;
}

@end
