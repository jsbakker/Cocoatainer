//
//  CCTResolution.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-14.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import <Foundation/Foundation.h>

#import "CCTRegistry.h"

@interface CCTResolution : NSObject

+(id)resolveComponent:(id)abstraction
              fromMap:(CCTRegistry*)registry;

+(id)resolveDependencies:(NSArray*)dependencies
                 fromMap:(CCTRegistry*)registry
              usingBlock:(id)block;
@end
