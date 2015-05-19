//
//  CCTConstructors.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-14.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import <Foundation/Foundation.h>

/*!
 A code block for supporting object initialization with no dependencies.
 @returns an initialized object.
 */
typedef id (^Initializer0)(void);

/*!
 A code block for supporting object initialization.
 @param 1st Dependency instance for initializer inside code block.
 @returns an initialized object.
 */
typedef id (^Initializer1)(id);

/*!
 A code block for supporting object initialization.
 @param 1st Dependency instance for initializer inside code block.
 @param 2nd Dependency instance for initializer inside code block.
 @returns an initialized object.
 */
typedef id (^Initializer2)(id, id);

/*!
 A code block for supporting object initialization.
 @param 1st Dependency instance for initializer inside code block.
 @param 2nd Dependency instance for initializer inside code block.
 @param 3rd Dependency instance for initializer inside code block.
 @returns an initialized object.
 */
typedef id (^Initializer3)(id, id, id);

/*!
 A code block for supporting object initialization.
 @param 1st Dependency instance for initializer inside code block.
 @param 2nd Dependency instance for initializer inside code block.
 @param 3rd Dependency instance for initializer inside code block.
 @param 4rd Dependency instance for initializer inside code block.
 @returns an initialized object.
 */
typedef id (^Initializer4)(id, id, id, id);

/*!
 A code block for supporting object initialization.
 @param 1st Dependency instance for initializer inside code block.
 @param 2nd Dependency instance for initializer inside code block.
 @param 3rd Dependency instance for initializer inside code block.
 @param 4rd Dependency instance for initializer inside code block.
 @param 5th Dependency instance for initializer inside code block.
 @returns an initialized object.
 */
typedef id (^Initializer5)(id, id, id, id, id);

/*!
 A code block for supporting object initialization.
 @param 1st Dependency instance for initializer inside code block.
 @param 2nd Dependency instance for initializer inside code block.
 @param 3rd Dependency instance for initializer inside code block.
 @param 4rd Dependency instance for initializer inside code block.
 @param 5th Dependency instance for initializer inside code block.
 @param 6th Dependency instance for initializer inside code block.
 @returns an initialized object.
 */
typedef id (^Initializer6)(id, id, id, id, id, id);

/*!
 A code block for supporting object initialization.
 @param NSArray an array of dependency instances for initializer inside code block.
 @returns an initialized object.
 */
typedef id (^Initializer)(NSArray*);
