//
//  CCTCocoatainer.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import <Foundation/Foundation.h>
#import "CCTInitializers.h"

@interface CCTCocoatainer : NSObject

-(void)registerComponent:(id)abstraction withInstance:(id)object;

-(void)registerComponent:(id)abstraction
               initsWith:(Initializer0)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
               initsWith:(Initializer1)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
               initsWith:(Initializer2)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
               initsWith:(Initializer3)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
               initsWith:(Initializer4)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
               initsWith:(Initializer5)block;

-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
                    and6:(id)d6
               initsWith:(Initializer6)block;

-(void)registerComponent:(id)abstraction
             dependentOn:(NSArray*)dependencies
               initsWith:(Initializer)block;

-(id)resolveComponent:(id)abstraction;

-(void)start:(BOOL)autoResolve;

@end
