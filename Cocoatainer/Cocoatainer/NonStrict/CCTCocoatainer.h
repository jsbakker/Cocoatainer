//
//  CCTCocoatainer.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import <Foundation/Foundation.h>
#import "CCTInitializers.h"

/*!
 An Inversion of Control container by way of constructor injection, which manages dependencies and allows all of its objects to be contained within its lifetime scope. Containers can be nested through parent relationships.
 */
@interface CCTCocoatainer : NSObject

/*!
 Adds a parent container to the receiver. All of the registered types in the parent container are then visible to the receiver, but does not work in the other direction. This effect can span generations of containers.
 @param parent The parent container which the receiver will be able to resolve types and dependencies from.
 @attention Parents generally will have a longer lifetime scope than their child scopes.
 */
-(void)addParent:(CCTCocoatainer*)parent;

/*!
 Register a pre-allocated instance into the container.
 @attention Parameter @p abstraction must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type to register as.
 @param object The instance which will return when resolved.
 @exception NSInvalidArgumentException
 */
-(void)registerComponent:(id)abstraction withInstance:(id)object;

/*!
 Register a type into the container with an initialization block.
 @attention Parameter @p abstraction must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type to register as.
 @param block A code block for object initialization to be executed at resolve time. Accepts no parameters and returns an object of type @p abstraction.
 @exception NSInvalidArgumentException
 */
-(void)registerComponent:(id)abstraction
               initsWith:(Initializer0)block;

/*!
 Register a type into the container with dependencies and an initialization block.
 @attention Parameter @p abstraction and @p d1 must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type to register as.
 @param d1 The first dependency.
 @param block A code block for object initialization to be executed at resolve time. Accepts a parameter instance of type @p d1 and returns an object of type @p abstraction.
 @exception NSInvalidArgumentException
 */
-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
               initsWith:(Initializer1)block;

/*!
 Register a type into the container with dependencies and an initialization block.
 @attention Parameter @p abstraction and @p d1, @p d2 must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type to register as.
 @param d1 The first dependency.
 @param d2 The second dependency.
 @param block A code block for object initialization to be executed at resolve time. Accepts parameter instances of type @p d1, @p d2 and returns an object of type @p abstraction.
 @exception NSInvalidArgumentException
 */
-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
               initsWith:(Initializer2)block;

/*!
 Register a type into the container with dependencies and an initialization block.
 @attention Parameter @p abstraction and @p d1, @p d2, @p d3  must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type to register as.
 @param d1 The first dependency.
 @param d2 The second dependency.
 @param d3 The third dependency.
 @param block A code block for object initialization to be executed at resolve time. Accepts parameter instances of type @p d1, @p d2, @p d3 and returns an object of type @p abstraction.
 @exception NSInvalidArgumentException
 */
-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
               initsWith:(Initializer3)block;

/*!
 Register a type into the container with dependencies and an initialization block.
 @attention Parameter @p abstraction and @p d1, @p d2, @p d3, @p d4 must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type to register as.
 @param d1 The first dependency.
 @param d2 The second dependency.
 @param d3 The third dependency.
 @param d4 The fourth dependency.
 @param block A code block for object initialization to be executed at resolve time. Accepts parameter instances of type @p d1, @p d2, @p d3, @p d4 and returns an object of type @p abstraction.
 @exception NSInvalidArgumentException
 */
-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
               initsWith:(Initializer4)block;

/*!
 Register a type into the container with dependencies and an initialization block.
 @attention Parameter @p abstraction and @p d1, @p d2, @p d3, @p d4, @p d5 must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type to register as.
 @param d1 The first dependency.
 @param d2 The second dependency.
 @param d3 The third dependency.
 @param d4 The fourth dependency.
 @param d5 The fifth dependency.
 @param block A code block for object initialization to be executed at resolve time. Accepts parameter instances of type @p d1, @p d2, @p d3, @p d4, @p d5 and returns an object of type @p abstraction.
 @exception NSInvalidArgumentException
 */
-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
               initsWith:(Initializer5)block;

/*!
 Register a type into the container with dependencies and an initialization block.
 @attention Parameter @p abstraction and @p d1, @p d2, @p d3, @p d4, @p d5, @p d6 must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type to register as.
 @param d1 The first dependency.
 @param d2 The second dependency.
 @param d3 The third dependency.
 @param d4 The fourth dependency.
 @param d5 The fifth dependency.
 @param d6 The sixth dependency.
 @param block A code block for object initialization to be executed at resolve time. Accepts parameter instances of type @p d1, @p d2, @p d3, @p d4, @p d5, @p d6 and returns an object of type @p abstraction.
 @exception NSInvalidArgumentException
 */
-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
                    and6:(id)d6
               initsWith:(Initializer6)block;

/*!
 Register a type into the container with dependencies and an initialization block.
 @attention Parameter @p abstraction and @p d1, @p d2, @p d3, @p d4, @p d5, @p d6, @p d7 must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type to register as.
 @param d1 The first dependency.
 @param d2 The second dependency.
 @param d3 The third dependency.
 @param d4 The fourth dependency.
 @param d5 The fifth dependency.
 @param d6 The sixth dependency.
 @param d7 The seventh dependency.
 @param block A code block for object initialization to be executed at resolve time. Accepts parameter instances of type @p d1, @p d2, @p d3, @p d4, @p d5, @p d6, @p d7 and returns an object of type @p abstraction.
 @exception NSInvalidArgumentException
 */
-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
                    and6:(id)d6
                    and7:(id)d7
               initsWith:(Initializer7)block;

/*!
 Register a type into the container with dependencies and an initialization block.
 @attention Parameter @p abstraction and @p d1, @p d2, @p d3, @p d4, @p d5, @p d6, @p d7, @p d8 must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type to register as.
 @param d1 The first dependency.
 @param d2 The second dependency.
 @param d3 The third dependency.
 @param d4 The fourth dependency.
 @param d5 The fifth dependency.
 @param d6 The sixth dependency.
 @param d7 The seventh dependency.
 @param d8 The eighth dependency.
 @param block A code block for object initialization to be executed at resolve time. Accepts parameter instances of type @p d1, @p d2, @p d3, @p d4, @p d5, @p d6, @p d7, @p d8 and returns an object of type @p abstraction.
 @exception NSInvalidArgumentException
 */
-(void)registerComponent:(id)abstraction
            dependentOn1:(id)d1
                    and2:(id)d2
                    and3:(id)d3
                    and4:(id)d4
                    and5:(id)d5
                    and6:(id)d6
                    and7:(id)d7
                    and8:(id)d8
               initsWith:(Initializer8)block;

/*!
 Register a type into the container with dependencies and an initialization block.
 @attention Parameter @p abstraction and the objects inside @p dependencies must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type to register as.
 @param dependencies An array of dependencies by type.
 @param block A code block for object initialization to be executed at resolve time. Accepts a parameter of NSArray* containing instances of dependencies to be injected and returns an object of type @p abstraction.
 @exception NSInvalidArgumentException
 */
-(void)registerComponent:(id)abstraction
             dependentOn:(NSArray*)dependencies
               initsWith:(Initializer)block;

/*!
 Resolves an instance of the requested type in the registry.
 @attention Parameter @p abstraction must be of type @p Class or @p Protocol* e.g. @p[MyClass @p class] or @p @@protocol(MyProtocol).
 @param abstraction The type requested to resolve.
 @returns An instance of type requested by @p abstraction.
 @exception NSInvalidArgumentException
 */
-(id)resolveComponent:(id)abstraction;

/*!
 Starts all objects in the registry which implement the @p CCTStartable protocol.
 @param autoResolve If NO, then only starts previously resolved instances. If YES then all objects are automatically resolved before starting.
 @warning Using start when dependency types aren't yet registered may causse failure.
 */
-(void)start:(BOOL)autoResolve;

@end
