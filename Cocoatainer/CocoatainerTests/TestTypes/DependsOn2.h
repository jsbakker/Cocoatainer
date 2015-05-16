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