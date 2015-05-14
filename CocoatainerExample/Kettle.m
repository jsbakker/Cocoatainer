//
//  Kettle.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "Kettle.h"

#define FULLCUP 250

@implementation Kettle

-(id)init
{
    self = [super init];
    if (self)
    {
        [self heat];
    }
    return self;
}

-(void)heat
{
    NSLog(@"Boiling water to 100 degrees C.");
}

-(NSInteger)pourCup
{
    NSLog(@"Pouring a cup of hot water.");
    return FULLCUP;
}

@end
