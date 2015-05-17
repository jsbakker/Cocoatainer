//
//  DescopeLogger.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-17.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILogger.h"
#import "ILog.h"

@interface DescopeLogger : NSObject

-(id)initWithLog:(id<ILog>)log;

@end

@interface DescopeLoggerA : DescopeLogger<ILoggerA>
@end

@interface DescopeLoggerB : DescopeLogger<ILoggerB>
@end
