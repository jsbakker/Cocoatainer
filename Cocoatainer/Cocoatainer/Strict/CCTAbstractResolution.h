//
//  CCTAbstractResolution.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-14.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CCTAbstractRegistry.h"

@interface CCTAbstractResolution : NSObject

+(id)resolveComponent:(Protocol*)abstraction
              fromMap:(CCTAbstractRegistry*)registry;

+(id)resolveDependencies:(NSArray*)dependencies
                 fromMap:(CCTAbstractRegistry*)registry
              usingBlock:(id)block;
@end
