//
//  CocoaPowder.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mix.h"

@protocol Topping <NSObject>
@end

@interface Marshmallow : NSObject<Topping>
@end

@interface CocoaPowder : NSObject<Mix>

-(id)initWithTopping:(id<Topping>)topping;
-(void)shovel;

@end
