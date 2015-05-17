//
//  DependsOnMultiple.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-17.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDependsOnMultiple.h"

@interface DependsOnMultiple : NSObject<IDependsOnMultiple>
@property (nonatomic) NSArray *injections;

-(id)initWithDependencies:(id)first, ...;
@end
