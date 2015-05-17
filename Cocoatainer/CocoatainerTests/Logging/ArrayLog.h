//
//  ArrayLog.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-16.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILog.h"

@interface ArrayLog : NSObject<ILog>

-(void)write:(NSString*)value;
-(NSArray*)getLines;

@end
