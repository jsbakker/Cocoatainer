//
//  CocoaMug.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoatainer/CCTStartable.h>
#import "LiquidVessel.h"
#import "HotWaterSource.h"
#import "Mix.h"
#import "ILog.h"

@interface CocoaMug : NSObject<LiquidVessel, CCTStartable>

-(id)initWithHotWater:(id<HotWaterSource>)source
           andMixture:(id<Mix>)cocoaMix
               andLog:(id<ILog>)log;
-(void)start;
-(void)fill;
-(void)drink:(NSInteger)amount;
-(void)checkAmount;

@end
