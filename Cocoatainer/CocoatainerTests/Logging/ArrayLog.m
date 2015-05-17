//
//  ArrayLog.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-16.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "ArrayLog.h"

@interface ArrayLog ()
{
@private
    NSMutableArray* _lines;
}
@end

@implementation ArrayLog

-(id)init
{
    self = [super init];
    if (self)
    {
        _lines = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)write:(NSString*)value
{
    [_lines addObject:value];
}

-(NSArray*)getLines
{
    return _lines;
}
@end
