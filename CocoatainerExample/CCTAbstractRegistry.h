//
//  CCTAbstractRegistry.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-15.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTAbstractedComponent.h"

typedef void (^TraverseComponents)(CCTAbstractedComponent*);

@interface CCTAbstractRegistry : NSObject

-(CCTAbstractedComponent*)getComponentRegistry:(NSString*)key;

-(void)traverseAndExecute:(TraverseComponents)action;

-(void)addComponent:(Protocol*)abstraction
       withInstance:(id)object;

-(void)addComponent:(Protocol*)abstraction
   withDependencies:(NSArray*)dependencies
     andConstructor:(id)constructor;

-(void)addComponent:(Protocol*)abstraction
   withDependencies:(NSArray*)dependencies
     andConstructor:(id)constructor
        andInstance:(id)instance;

@end
