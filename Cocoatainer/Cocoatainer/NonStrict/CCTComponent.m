//
//  CCTComponent.m
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//
//  Distributed under the MIT License.
//  See accompanying file LICENSE.md or copy at
//  http://opensource.org/licenses/MIT

#import "CCTComponent.h"

@implementation CCTComponent

-(void)dealloc
{
    self.abstracion = nil;
    self.dependencies = nil;
    self.constructor = nil;
    self.instance = nil;
}

@end
