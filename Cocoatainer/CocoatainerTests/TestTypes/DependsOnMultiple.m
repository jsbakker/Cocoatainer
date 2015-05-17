//
//  DependsOnMultiple.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-17.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "DependsOnMultiple.h"

@implementation DependsOnMultiple

-(id)initWithDependencies:(id)first, ...
{
    id eachObject;
    va_list argumentList;

    NSMutableArray* injections = [NSMutableArray array];

    if (first)
    {
        // first is not part of va_args
        [injections addObject:first];
        va_start(argumentList, first);

        // After first, add each id object until we hit nil
        while ((eachObject = va_arg(argumentList, id)))
        {
            [injections addObject: eachObject];
        }
        va_end(argumentList);
    }

    self.injections = injections;
    return self;
}
@end