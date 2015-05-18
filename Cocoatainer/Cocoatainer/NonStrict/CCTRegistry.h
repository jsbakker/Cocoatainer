//
//  CCTRegistry.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-15.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import <Foundation/Foundation.h>
#import "CCTComponent.h"

typedef void (^TraverseComponents)(CCTComponent*);

@interface CCTRegistry : NSObject

@property (nonatomic) BOOL strict;

-(void)addParent:(CCTRegistry*)parent;

-(CCTComponent*)getComponentRegistry:(NSString*)key;

-(void)traverseAndExecute:(TraverseComponents)action;

-(void)addComponent:(id)abstraction
       withInstance:(id)object;

-(void)addComponent:(id)abstraction
   withDependencies:(NSArray*)dependencies
     andConstructor:(id)constructor;

-(void)addComponent:(id)abstraction
   withDependencies:(NSArray*)dependencies
     andConstructor:(id)constructor
        andInstance:(id)instance;

@end
