//
//  LiquidVessel.h
//  CocoatainerExample
//
//  Created by Jeffrey Bakker on 2015-05-13.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LiquidVessel <NSObject>

-(void)fill;
-(void)drink:(NSInteger)amount;
-(void)checkAmount;

@end