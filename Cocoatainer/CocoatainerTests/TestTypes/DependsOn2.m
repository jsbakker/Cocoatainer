//
//  DependsOn2.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-15.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "DependsOn2.h"

@implementation DependsOn2A
-(id)initWithD1:(id<INoDepsA>)d1 and2:(id<INoDepsB>)d2
{
    self = [super init];
    if (self)
    {
        self.dependency1 = d1;
        self.dependency2 = d2;
    }
    return self;
}
@end

@implementation DependsOn2B
-(id)initWithD1:(id<IDependsOn1A>)d1 and2:(id<INoDepsB>)d2
{
    self = [super init];
    if (self)
    {
        self.dependency1 = d1;
        self.dependency2 = d2;
    }
    return self;
}
@end

@implementation DependsOn2C
-(id)initWithD1:(id<IDependsOn1A>)d1 and2:(id<INoDepsA>)d2
{
    self = [super init];
    if (self)
    {
        self.dependency1 = d1;
        self.dependency2 = d2;
    }
    return self;
}
@end

@implementation DependsOn2Startables
-(id)initWithD1:(id<ILoggerA>)d1 and2:(id<ILoggerB>)d2
{
    self = [super init];
    if (self)
    {
        self.dependency1 = d1;
        self.dependency2 = d2;
    }
    return self;
}
@end

@implementation DependsOn2StartablesAB
-(id)initWithD1:(id<ILoggerA>)d1 and2:(id<ILoggerB>)d2
{
    self = [super init];
    if (self)
    {
        self.dependency1 = d1;
        self.dependency2 = d2;
    }
    return self;
}
@end

@implementation DependsOn2StartablesBA
-(id)initWithD1:(id<ILoggerB>)d1 and2:(id<ILoggerA>)d2
{
    self = [super init];
    if (self)
    {
        self.dependency1 = d1;
        self.dependency2 = d2;
    }
    return self;
}
@end
