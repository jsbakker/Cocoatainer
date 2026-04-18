//
//  CCTAbstractCocoatainer.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import <Foundation/Foundation.h>
#import <Cocoatainer/CCTCocoatainer.h>

/*!
 An Inversion of Control container by way of constructor injection, which manages dependencies and allows all of its objects to be contained within its lifetime scope. Containers can be nested through parent relationships.
 @attention This is the strict version of the container class, allowing registration of only abstract types.
 */
@interface CCTAbstractCocoatainer : CCTCocoatainer

-(id)resolveComponent:(id)abstraction;

@end
