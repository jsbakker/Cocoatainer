//
//  CocoatainerConfiguration.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^CreationBlock0)(void);
typedef id (^CreationBlock1)(id);
typedef id (^CreationBlock2)(id, id);
typedef id (^CreationBlock3)(id, id, id);
typedef id (^CreationBlock4)(id, id, id, id);
typedef id (^CreationBlock5)(id, id, id, id, id);

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

-(id)resolveComponent:(Protocol*)abstraction;

-(void)start;

@end
