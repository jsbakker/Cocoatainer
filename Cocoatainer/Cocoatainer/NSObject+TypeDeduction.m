//
//  NSObject+TypeDeduction.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-16.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import "NSObject+TypeDeduction.h"

@implementation NSObject (TypeDeduction)
-(BOOL)isConcrete
{
    return [self respondsToSelector:@selector(alloc)];
}
@end
