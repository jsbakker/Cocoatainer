//
//  CCTAbstractCocoatainer.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import "CCTAbstractCocoatainer.h"
#import "NSObject+TypeDeduction.h"

@interface CCTCocoatainer (Protected)
-(void)setAbstract;
@end

@implementation CCTAbstractCocoatainer

-(id)init
{
    self = [super init];
    if(self)
    {
        [self setAbstract];
    }
    return self;
}

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
