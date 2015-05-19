//
//  NSObject+TypeDeduction.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-16.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import <Foundation/Foundation.h>

@interface NSObject (TypeDeduction)

/*!
 Checks if the receiver is a concrete class.
 @returns YES if the receiver is a concrete @p Class, NO if its a @p Protocol.
 */
-(BOOL)isConcrete;

/*!
 Checks if the receiver is a concrete class.
 @returns YES if the receiver has been instantiated. NO if it has not or cannot.
 */
-(BOOL)isInstance;
@end
