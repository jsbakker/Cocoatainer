//
//  CocoaPowder.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "CocoaPowder.h"

@interface CocoaPowder ()
{
@private
    id<Topping> _topping;
    id<ILog> _log;
}
@end
@implementation CocoaPowder

-(id)initWithTopping:(id<Topping>)topping
              andLog:(id<ILog>)log
{
    self = [super init];
    if (self)
    {
        _topping = topping;
        _log = log;
    }
    return self;
}

-(void)dealloc
{
    [_log write:@"This cocoa powder has coagulated at the bottom."];
}

-(void)start
{
    [_log write:@"Creating %@ mix with %@ topping.",
          NSStringFromClass([self class]), [_topping name]];
}

-(void)shovel
{
    [_log write:@"Shovel three tablespoons of mixture."];
}

@end
