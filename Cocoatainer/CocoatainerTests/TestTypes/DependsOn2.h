//
//  DependsOn2.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-15.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDependsOn1.h"
#import "IDependsOn2.h"
#import "INoDeps.h"
#import "ILogger.h"

@interface DependsOn2A : NSObject<IDependsOn2A>
@property id<INoDepsA> dependency1;
@property id<INoDepsB> dependency2;
-(id)initWithD1:(id<INoDepsA>)d1 and2:(id<INoDepsB>)d2;
@end

@interface DependsOn2B : NSObject<IDependsOn2B>
@property id<IDependsOn1A> dependency1;
@property id<INoDepsB> dependency2;
-(id)initWithD1:(id<IDependsOn1A>)d1 and2:(id<INoDepsB>)d2;
@end

@interface DependsOn2C : NSObject<IDependsOn2C>
@property id<IDependsOn1A> dependency1;
@property id<INoDepsA> dependency2;
-(id)initWithD1:(id<IDependsOn1A>)d1 and2:(id<INoDepsA>)d2;
@end

@interface DependsOn2Startables : NSObject<IDependsOn2Startables>
@property id<ILoggerA> dependency1;
@property id<ILoggerB> dependency2;
-(id)initWithD1:(id<ILoggerA>)d1 and2:(id<ILoggerB>)d2;
@end

@interface DependsOn2StartablesAB : NSObject<IDependsOn2StartablesAB>
@property id<ILoggerA> dependency1;
@property id<ILoggerB> dependency2;
-(id)initWithD1:(id<ILoggerA>)d1 and2:(id<ILoggerB>)d2;
@end

@interface DependsOn2StartablesBA : NSObject<IDependsOn2StartablesBA>
@property id<ILoggerB> dependency1;
@property id<ILoggerA> dependency2;
-(id)initWithD1:(id<ILoggerB>)d1 and2:(id<ILoggerA>)d2;
@end
