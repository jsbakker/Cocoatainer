//
//  CCTAbstractCocoatainer.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "CCTAbstractCocoatainer.h"
#import "NSObject+TypeDeduction.h"

@implementation CCTAbstractCocoatainer

//-(id)init
//{
//    self = [super init];
//    if(self)
//    {
//        _model.strict = YES;
//    }
//    return self;
//}

-(id)resolveComponent:(id)abstraction
{
    if ([abstraction isConcrete])
    {
        [NSException raise:NSInvalidArgumentException
                    format:@"Cannot resolve concrete types in abstract container."];
    }
    return [super resolveComponent:abstraction];
}

@end
