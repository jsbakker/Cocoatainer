//
//  TextViewLog.h
//  CocoatainerGuiExample
//
//  Created by Jeffrey Bakker on 2015-05-19.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ILog.h"

@interface TextViewLog : NSObject<ILog>

-(id)initWithTextView:(UITextView*)view;
-(void)write:(NSString*)format, ...;

@end
