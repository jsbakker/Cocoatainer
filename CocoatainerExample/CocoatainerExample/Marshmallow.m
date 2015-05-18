//
//  Marshmallow.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-14.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "Marshmallow.h"

@implementation Marshmallow

-(void)dealloc
{
    NSLog(@"This marshmallow is so soggy that it has nearly turned into liquid.");
}

-(NSString*)name
{
    return NSStringFromClass([self class]);
}

@end
