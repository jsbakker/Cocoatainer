//
//  NSObject+TypeDeduction.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-16.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "NSObject+TypeDeduction.h"

@implementation NSObject (TypeDeduction)
-(BOOL)isConcrete
{
    return [self respondsToSelector:@selector(alloc)];
}
@end
