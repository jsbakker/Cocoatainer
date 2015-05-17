//
//  AbstractedComponent.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCTComponent : NSObject

@property (nonatomic) BOOL resolution;
@property (nonatomic) Class abstracion;
@property (nonatomic) NSArray *dependencies;
@property (nonatomic) id constructor;
@property (nonatomic) id instance;

@end
