//
//  NoDeps.h
//  Cocoatainer
//
//  Created by Jeffrey Bakker on 2015-05-15.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INoDeps.h"

@interface NoDepsA : NSObject<INoDepsA>
@end

@interface NoDepsB : NSObject<INoDepsB>
@end

@interface NoDepsC : NSObject<INoDepsC>
@end