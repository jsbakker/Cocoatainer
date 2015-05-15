//
//  CocoatainerConfiguration.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTConstructors.h"

@interface CCTCocoatainerConfiguration : NSObject

-(void)registerComponent:(Protocol*)abstraction withInstance:(id)object;

-(void)registerComponent:(Protocol*)abstraction
               withBlock:(CreationBlock0)block;

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
               withBlock:(CreationBlock1)block;

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
                    and2:(Protocol*)d2
               withBlock:(CreationBlock2)block;

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
                    and2:(Protocol*)d2
                    and3:(Protocol*)d3
               withBlock:(CreationBlock3)block;

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
                    and2:(Protocol*)d2
                    and3:(Protocol*)d3
                    and4:(Protocol*)d4
               withBlock:(CreationBlock4)block;

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
                    and2:(Protocol*)d2
                    and3:(Protocol*)d3
                    and4:(Protocol*)d4
                    and5:(Protocol*)d5
               withBlock:(CreationBlock5)block;

-(void)registerComponent:(Protocol*)abstraction
            dependentOn1:(Protocol*)d1
                    and2:(Protocol*)d2
                    and3:(Protocol*)d3
                    and4:(Protocol*)d4
                    and5:(Protocol*)d5
                    and6:(Protocol*)d6
               withBlock:(CreationBlock6)block;

-(id)resolveComponent:(Protocol*)abstraction;

-(void)start:(BOOL)autoResolve;

@end
