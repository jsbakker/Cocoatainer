//
//  CCTCocoatainer.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+TypeDeduction.h"
#import "CCTConstructors.h"

@interface CCTCocoatainer : NSObject

-(void)registerComponent:(Class)abstraction withInstance:(id)object;

-(void)registerComponent:(Class)abstraction
               withBlock:(CreationBlock0)block;

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
               withBlock:(CreationBlock1)block;

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
                    and2:(Class)d2
               withBlock:(CreationBlock2)block;

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
                    and2:(Class)d2
                    and3:(Class)d3
               withBlock:(CreationBlock3)block;

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
                    and2:(Class)d2
                    and3:(Class)d3
                    and4:(Class)d4
               withBlock:(CreationBlock4)block;

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
                    and2:(Class)d2
                    and3:(Class)d3
                    and4:(Class)d4
                    and5:(Class)d5
               withBlock:(CreationBlock5)block;

-(void)registerComponent:(Class)abstraction
            dependentOn1:(Class)d1
                    and2:(Class)d2
                    and3:(Class)d3
                    and4:(Class)d4
                    and5:(Class)d5
                    and6:(Class)d6
               withBlock:(CreationBlock6)block;

-(id)resolveComponent:(Class)abstraction;

-(void)start:(BOOL)autoResolve;

@end
