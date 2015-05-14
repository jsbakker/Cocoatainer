//
//  AppDelegate.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "AppDelegate.h"
#import "CCTCocoatainerConfiguration.h"

#import "CocoaMug.h"
#import "Kettle.h"
#import "CocoaPowder.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    CCTCocoatainerConfiguration* config = [[CCTCocoatainerConfiguration alloc] init];

    [config registerComponent:@protocol(HotWaterSource) withBlock:
     ^{
         return [[Kettle alloc] init];
     }];

    [config registerComponent:@protocol(Mix)
                 dependentOn1:@protocol(Topping)
                    withBlock:
     ^(id<Topping> topping){
         return [[CocoaPowder alloc] initWithTopping:topping];
     }];

    [config registerComponent:@protocol(LiquidVessel)
                 dependentOn1:@protocol(HotWaterSource)
                         and2:@protocol(Mix)
                    withBlock:
     ^(id<HotWaterSource> source, id<Mix> mix){
         return [[CocoaMug alloc] initWithHotWater:source andMixture:mix];
     }];

    id<LiquidVessel> myMug = [config resolveComponent:@protocol(LiquidVessel)];
    [myMug fill];
    [myMug drink:20];
    [myMug checkAmount];
    [myMug drink:30];
    [myMug checkAmount];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
