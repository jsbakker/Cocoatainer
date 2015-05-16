//
//  DependsOn1.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-15.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDependsOn1.h"
#import "INoDeps.h"

@interface DependsOn1A : NSObject<IDependsOn1A>
@property id<INoDepsA> dependency1;
-(id)initWithD1:(id<INoDepsA>)d1;
@end

@interface DependsOn1B : NSObject<IDependsOn1B>
@property id<INoDepsB> dependency1;
-(id)initWithD1:(id<INoDepsB>)d1;
@end