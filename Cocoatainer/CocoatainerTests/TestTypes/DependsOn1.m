//
//  DependsOn1.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-15.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "DependsOn1.h"

@implementation DependsOn1A
-(id)initWithD1:(id<INoDepsA>)d1
{
    self = [super init];
    if (self)
    {
        self.dependency1 = d1;
    }
    return self;
}
@end

@implementation DependsOn1B
-(id)initWithD1:(id<INoDepsB>)d1
{
    self = [super init];
    if (self)
    {
        self.dependency1 = d1;
    }
    return self;
}
@end
