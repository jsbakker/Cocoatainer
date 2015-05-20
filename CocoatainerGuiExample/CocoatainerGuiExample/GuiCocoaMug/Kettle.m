//
//  Kettle.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "Kettle.h"

#define FULLCUP 250

@interface Kettle ()
{
@private
    id<ILog> _log;
}
@end

@implementation Kettle

-(id)initWithLog:(id<ILog>)log
{
    self = [super init];
    if (self)
    {
        _log = log;
    }
    return self;
}

-(void)dealloc
{
    [_log write:@"This water got cold and looks old. I will dump it out."];
}

-(void)start
{
    [self heat];
}

-(void)heat
{
    [_log write:@"Boiling water to 100 degrees C."];
}

-(NSInteger)pourCup
{
    [_log write:@"Pouring a cup of hot water."];
    return FULLCUP;
}

@end
