//
//  CCTCocoatainer.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTConstructors.h"

@interface CCTCocoatainer : NSObject

-(void)registerComponent:(id)abstraction withInstance:(id)object;

-(void)registerComponent:(id)abstraction
               withBlock:(CreationBlock0)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
               withBlock:(CreationBlock1)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
               withBlock:(CreationBlock2)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
               withBlock:(CreationBlock3)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
               withBlock:(CreationBlock4)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
               withBlock:(CreationBlock5)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
                    and6:(id)d6
               withBlock:(CreationBlock6)block;

-(id)resolveComponent:(id)abstraction;

-(void)start:(BOOL)autoResolve;

@end
