//
//  Kettle.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoatainer/CCTStartable.h>
#import "HotWaterSource.h"
#import "ILog.h"

@interface Kettle : NSObject<HotWaterSource, CCTStartable>

-(id)initWithLog:(id<ILog>)log;

-(void)start;
-(void)heat;
-(NSInteger)pourCup;

@end
