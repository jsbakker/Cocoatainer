//
//  StartupLogger.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-16.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoatainer/CCTStartable.h>
#import "ILogger.h"
#import "ILog.h"

@interface StartupLogger : NSObject<CCTStartable>

-(id)initWithLog:(id<ILog>)log;
-(void)start;

@end

@interface StartupLoggerA : StartupLogger<ILoggerA>
@end

@interface StartupLoggerB : StartupLogger<ILoggerB>
@end
