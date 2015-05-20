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
    id<ILog> _log;
    NSInteger _millilitres;
}
@end

@implementation CocoaMug

-(id)initWithHotWater:(id<HotWaterSource>)source
           andMixture:(id<Mix>)cocoaMix
               andLog:(id<ILog>)log
{
    self = [super init];
    if (self)
    {
        _hotWaterSource = source;
        _cocoaMix = cocoaMix;
        _log = log;
        _millilitres = 0;
    }
    return self;
}

-(void)dealloc
{
    [_log write:
     @"Someone left this %ld ml full mug here. I will just pour it out.",
     _millilitres ];

    _hotWaterSource = nil;
    _cocoaMix = nil;
}

-(void)start
{
    [self fill];
}

-(void)fill
{
    [_cocoaMix shovel];
    _millilitres = [_hotWaterSource pourCup];
    [_log write:@"Mug is filled to %ld ml of hot Cocoa.", _millilitres];
}

-(void)drink:(NSInteger)amount
{
    if (_millilitres == 0)
    {
        [_log write:@"The mug is empty."];
        return;
    }

    [_log write:@"Drinking %ld ml from the mug.", amount];
    _millilitres -= amount;
    if (_millilitres < 0)
    {
        _millilitres = 0;
    }
}

-(void)checkAmount
{
    [_log write:@"There is %ld ml of cocoa left in the mug.", _millilitres];
}
@end
