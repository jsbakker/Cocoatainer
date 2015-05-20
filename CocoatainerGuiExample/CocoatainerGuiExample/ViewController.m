//
//  ViewController.m
//  CocoatainerGuiExample
//
//  Created by Jeffrey Bakker on 2015-05-19.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

#import "ViewController.h"
#import "TextViewLog.h"
#import "ILog.h"

#import "CocoaMug.h"
#import "Kettle.h"
#import "CocoaPowder.h"
#import "Marshmallow.h"

@interface ViewController ()
{
@private
    // This container's scope is managed based on user workflow.
    // It can resolve views from its parent which has a wider
    // reaching scope.
    CCTCocoatainer* _container;
    BOOL _initialized;
}

-(void)registerViewTypes;
-(void)registerNonViewTypes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Once the view is loaded from IB, it is safe to register view objects.
    [self registerViewTypes];
    [self registerNonViewTypes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerViewTypes
{
    // Any view-facing code should be added into the
    // views container, with a long-lived scope matching
    // the ViewController's lifecycle.

    [_viewsContainer registerComponent:[UITextView class]
                          withInstance:_textView];

    [_viewsContainer registerComponent:@protocol(ILog)
                          dependentOn1:[UITextView class]
                             initsWith:^(UITextView* view)
     {
         return [[TextViewLog alloc] initWithTextView:view];
     }];
}

-(void)registerNonViewTypes
{
    // This container can come up and down several times
    // within the total lifecycle of the application. It
    // can still resovle dependency types from its parent
    // container.

    _container = [[CCTCocoatainer alloc] init];
    [_container addParent:_viewsContainer];

    [_container registerComponent:@protocol(HotWaterSource)
                     dependentOn1:@protocol(ILog)
                        initsWith:
     ^(id<ILog> log){
         return [[Kettle alloc] initWithLog:log];
     }];

    [_container registerComponent:@protocol(Topping)
                     dependentOn1:@protocol(ILog)
                        initsWith:
     ^(id<ILog> log){
         return [[Marshmallow alloc] initWithLog:log];
     }];

    [_container registerComponent:@protocol(Mix)
                     dependentOn1:@protocol(Topping)
                             and2:@protocol(ILog)
                        initsWith:
     ^(id<Topping> topping, id<ILog> log){
         return [[CocoaPowder alloc] initWithTopping:topping andLog:log];
     }];

    [_container registerComponent:@protocol(LiquidVessel)
                     dependentOn1:@protocol(HotWaterSource)
                             and2:@protocol(Mix)
                             and3:@protocol(ILog)
                        initsWith:
     ^(id<HotWaterSource> source, id<Mix> mix, id<ILog> log){
         return [[CocoaMug alloc] initWithHotWater:source
                                        andMixture:mix
                                            andLog:log];
     }];
}

-(IBAction)prepareCocoaClicked:(id)sender
{
    if (_initialized)
    {
        return;
    }

    // This is where the objects from the container will be
    // resolved.
    [_container start:YES];
    _initialized = YES;
}

-(IBAction)takeSipClicked:(id)sender
{
    if (!_initialized)
    {
        return;
    }

    // This is a local reference to LiquidVessel, meaning the container
    // is the only link to the objects it contains.
    id<LiquidVessel> mug =
        [_container resolveComponent:@protocol(LiquidVessel)];

    [mug drink:25];
    [mug checkAmount];
}

-(IBAction)walkAwayClicked:(id)sender
{
    // Removing the only reference to the container instance will cause
    // its children to dispose, if there are no references to them.

    _container = nil;
    _initialized = NO;

    // Re-create the container and registrations, but the objects
    // themselves won't be initialized until needed.
    [self registerNonViewTypes];
}
@end
