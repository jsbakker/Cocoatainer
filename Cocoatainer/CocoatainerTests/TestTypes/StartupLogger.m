//
//  StartupLogger.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-16.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "StartupLogger.h"

@interface StartupLogger ()
{
@private
    id<ILog> _log;
}
@end

@implementation StartupLogger

-(id)initWithLog:(id<ILog>)log
{
    self = [super init];
    if (self)
    {
        _log = log;
    }
    return self;
}

-(void)start
{
    NSString* writable =
        [NSString stringWithFormat:@"%@", NSStringFromClass([self class])];
    [_log write:writable];
}

@end

@implementation StartupLoggerA
@end

@implementation StartupLoggerB
@end
