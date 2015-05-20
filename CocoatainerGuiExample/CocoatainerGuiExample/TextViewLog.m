//
//  TextViewLog.m
//  CocoatainerGuiExample
//
//  Created by Jeffrey Bakker on 2015-05-19.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "TextViewLog.h"

@interface TextViewLog ()
{
@private
    UITextView* _textView;
}
@end

@implementation TextViewLog

-(id)initWithTextView:(UITextView*)view
{
    self = [super init];
    if (self)
    {
        _textView = view;
    }
    return self;
}

-(void)write:(NSString*)format, ...
{
    NSString* value;

    va_list args;
    va_start(args, format);
    value = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);

    NSString* backLog = _textView.text;
    _textView.text = [NSString stringWithFormat:@"%@\n%@", value, backLog];
}

@end
