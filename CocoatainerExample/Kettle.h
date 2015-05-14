//
//  Kettle.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotWaterSource.h"

@interface Kettle : NSObject<HotWaterSource>

-(void)heat;
-(NSInteger)pourCup;

@end
