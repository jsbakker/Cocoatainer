//
//  JSBAbstractedComponent.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSBAbstractedComponent : NSObject

@property (nonatomic) Protocol *abstracion;
@property (nonatomic) NSArray *dependencies;
@property (nonatomic) BOOL resolution;
@property (nonatomic) id constructor;

@end
