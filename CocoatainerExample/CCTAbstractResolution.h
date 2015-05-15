//
//  CCTAbstractResolution.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-14.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCTAbstractResolution : NSObject

+(id)resolveComponent:(Protocol*)abstraction
              fromMap:(NSDictionary*)components;

+(id)resolveDependencies:(NSArray*)dependencies
                 fromMap:(NSDictionary*)components
              usingBlock:(id)block;
@end
