//
//  ILog.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-16.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILog <NSObject>

-(void)write:(NSString*)value;
-(NSArray*)getLines;

@end
