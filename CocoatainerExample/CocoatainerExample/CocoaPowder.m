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
}
@end
@implementation CocoaPowder

-(id)initWithTopping:(id<Topping>)topping
{
    self = [super init];
    if (self)
    {
        _topping = topping;
    }
    return self;
}

-(void)dealloc
{
    NSLog(@"This cocoa powder has coagulated at the bottom.");
}

-(void)start
{
    NSLog(@"Creating %@ mix with %@ topping",
          NSStringFromClass([self class]), [_topping name]);
}

-(void)shovel
{
    NSLog(@"Shovel three tablespoons of mixture.");
}

@end
