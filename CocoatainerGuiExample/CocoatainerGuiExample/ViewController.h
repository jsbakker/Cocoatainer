//
//  ViewController.h
//  CocoatainerGuiExample
//
//  Created by Jeffrey Bakker on 2015-05-19.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cocoatainer/Cocoatainer.h>

@interface ViewController : UIViewController
{
    // This container is managed by IB and has a lifetime scope
    // matching the View scope, therefore this container is
    // suitable for registering instances of View-facing code.
    IBOutlet CCTCocoatainer* _viewsContainer;
    IBOutlet UITextView* _textView;
}

-(IBAction)prepareCocoaClicked:(id)sender;
-(IBAction)takeSipClicked:(id)sender;
-(IBAction)walkAwayClicked:(id)sender;
@end

