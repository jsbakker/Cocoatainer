//
//  CocoaMug.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiquidVessel.h"
#import "HotWaterSource.h"
#import "Mix.h"

@interface CocoaMug : NSObject<LiquidVessel>

-(id)initWithHotWater:(id<HotWaterSource>)source
           andMixture:(id<Mix>)cocoaMix;
-(void)fill;
-(void)drink:(NSInteger)amount;
-(void)checkAmount;

@end
