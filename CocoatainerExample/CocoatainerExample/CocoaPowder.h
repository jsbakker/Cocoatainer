//
//  CocoaPowder.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoatainer/CCTStartable.h>
#import "Mix.h"
#import "Topping.h"

@interface CocoaPowder : NSObject<Mix, CCTStartable>

-(id)initWithTopping:(id<Topping>)topping;
-(void)shovel;

@end
