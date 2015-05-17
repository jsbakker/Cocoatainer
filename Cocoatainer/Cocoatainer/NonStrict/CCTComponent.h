//
//  CCTComponent.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import <Foundation/Foundation.h>

@interface CCTComponent : NSObject

@property (nonatomic) BOOL resolution;
@property (strong, nonatomic) id abstracion;
@property (strong, nonatomic) NSArray *dependencies;
@property (strong, nonatomic) id constructor;
@property (strong, nonatomic) id instance;

@end
