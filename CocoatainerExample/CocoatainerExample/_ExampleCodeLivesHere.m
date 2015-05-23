//
//  _ExampleCodeLivesHere.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-17.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "_ExampleCodeLivesHere.h"

#import <Cocoatainer/Cocoatainer.h>

#import "CocoaMug.h"
#import "Kettle.h"
#import "CocoaPowder.h"
#import "Marshmallow.h"

@implementation _ExampleCodeLivesHere

+(void)runCocoaMugExample1
{
    id mug;
    @autoreleasepool // comment out to let the local scope unwind the container
    {
        CCTAbstractCocoatainer* config =
        [[CCTAbstractCocoatainer alloc] init];

        [config registerComponent:@protocol(HotWaterSource)
                     withInstance:[[Kettle alloc] init]];

        [config registerComponent:@protocol(Topping)
                     withInstance:[[Marshmallow alloc] init]];

        [config registerComponent:@protocol(Mix)
                     dependentOn1:@protocol(Topping)
                        initsWith:
         ^(id<Topping> topping){
             return [[CocoaPowder alloc] initWithTopping:topping];
         }];

        [config registerComponent:@protocol(LiquidVessel)
                     dependentOn1:@protocol(HotWaterSource)
                             and2:@protocol(Mix)
                        initsWith:
         ^(id<HotWaterSource> source, id<Mix> mix){
             return [[CocoaMug alloc] initWithHotWater:source andMixture:mix];
         }];

        // TODO - Fix me. This was working at one point.
        // Comment the above registry and uncomment below to change the order
        // of dependencies. Notice the order of which the -(void)start methods
        // are called between the Mix and the HotWaterSource.
        //        [config registerComponent:@protocol(LiquidVessel)
        //                     dependentOn1:@protocol(Mix)
        //                             and2:@protocol(HotWaterSource)
        //                        withBlock:
        //         ^(id<Mix> mix, id<HotWaterSource> source){
        //             return [[CocoaMug alloc] initWithHotWater:source andMixture:mix];
        //         }];

        [config start:YES];

        id<LiquidVessel> myMug =
        [config resolveComponent:@protocol(LiquidVessel)];

        [myMug drink:20];
        [myMug checkAmount];
        [myMug drink:30];
        [myMug checkAmount];

        // uncomment to see object live outside of the autoreleasepool, where
        // it will finally descope when the local scope ends.
        //mug = myMug;
    }
    NSLog(@"Before method's local scope end.");
}

@end
