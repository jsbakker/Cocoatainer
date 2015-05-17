//
//  CocoaMug.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "CocoaMug.h"

@interface CocoaMug ()
{
@private
    id<HotWaterSource> _hotWaterSource;
    id<Mix> _cocoaMix;
    NSInteger _millilitres;
}
@end

@implementation CocoaMug

-(id)initWithHotWater:(id<HotWaterSource>)source
           andMixture:(id<Mix>)cocoaMix
{
    self = [super init];
    if (self)
    {
        _hotWaterSource = source;
        _cocoaMix = cocoaMix;
        _millilitres = 0;
    }
    return self;
}

-(void)start
{
    [self fill];
}

-(void)fill
{
    [_cocoaMix shovel];
    _millilitres = [_hotWaterSource pourCup];
    NSLog(@"Mug is filled to %ld ml of hot Cocoa: ", _millilitres);
}

-(void)drink:(NSInteger)amount
{
    NSLog(@"Drinking %ld ml from the mug", amount);
    _millilitres -= amount;
}

-(void)checkAmount
{
    NSLog(@"There is %ld ml of cocoa left in the mug", _millilitres);
}
@end
