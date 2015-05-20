//
//  Marshmallow.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-14.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topping.h"
#import "ILog.h"

@interface Marshmallow : NSObject<Topping>

-(id)initWithLog:(id<ILog>)log;

-(NSString*)name;

@end
