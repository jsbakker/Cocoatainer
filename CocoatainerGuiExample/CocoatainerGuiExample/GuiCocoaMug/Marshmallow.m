//
//  Marshmallow.m
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-14.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "Marshmallow.h"

@interface Marshmallow ()
{
@private
    id<ILog> _log;
}
@end

@implementation Marshmallow

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
    [_log write:
     @"This marshmallow is so soggy that it has nearly turned into liquid."];
}

-(NSString*)name
{
    return NSStringFromClass([self class]);
}

@end
