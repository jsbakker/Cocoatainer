//
//  CCTStartable.h
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
 A protocol to implement for your registered object to become startable.
 */
@protocol CCTStartable <NSObject>

/*!
 When @p start on the container of the registered object is called, the so will the start message of all startable objects in the container.
 */
-(void)start;

@end
