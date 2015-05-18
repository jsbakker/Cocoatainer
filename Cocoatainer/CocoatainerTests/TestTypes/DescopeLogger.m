//
//  DescopeLogger.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-17.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "DescopeLogger.h"

@interface DescopeLogger ()
{
@private
    id<ILog> _log;
}
@end

@implementation DescopeLogger

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
    NSString* writable =
        [NSString stringWithFormat:@"dealloc in %@",
         NSStringFromClass([self class])];
    [_log write:writable];
}

@end

@implementation DescopeLoggerA
@end

@implementation DescopeLoggerB
@end
