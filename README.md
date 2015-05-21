# README #

Welcome to the Cocoatainer project. This project is aimed at providing Objective-C developers with an iOS framework for [Dependency Injection](http://en.wikipedia.org/wiki/Dependency_injection) / [Inversion of Control](http://en.wikipedia.org/wiki/Inversion_of_control). 
 
Cocoatainer provides an IoC container with constructor injection. What makes it different is that it supports registering components either by abstract (protocol) or by concrete type (class), although there is also a strict, abstract-only version as well. The container also supports:

* Adding components by block (anonymous function) with dependencies
* Adding components by pre-allocated instance
* Multiple dependencies, auto-resolving when needed
* Nested dependencies, auto-resolving when needed
* Nested containers (with auto-resolving dependencies from parent)
* Startable (with option of auto-resolution of objects not referenced outside the container, i.e. object lives solely in the container)
* Error checking on registration (throws), to help prevent logical errors after resolution
* API docs via XCode Quick Help tab

The Cocoatainer framework code is covered by several dozen unit tests around the above scenarios. 

### CocoaMug Example ###

If you wanted some hot cocoa, first you'd need [some sort of mug](https://bitbucket.org/staeryatz/cocoatainer/src/778730c058715f5e9727353bd4aa5c0351fe575d/CocoatainerExample/CocoatainerExample/CocoaMug.h?at=master) to put it in, get hot water from [somewhere](https://bitbucket.org/staeryatz/cocoatainer/src/778730c058715f5e9727353bd4aa5c0351fe575d/CocoatainerExample/CocoatainerExample/Kettle.h?at=master), and of course some [mixture](https://bitbucket.org/staeryatz/cocoatainer/src/778730c058715f5e9727353bd4aa5c0351fe575d/CocoatainerExample/CocoatainerExample/CocoaPowder.h?at=master), which may also contain [toppings](https://bitbucket.org/staeryatz/cocoatainer/src/778730c058715f5e9727353bd4aa5c0351fe575d/CocoatainerExample/CocoatainerExample/Marshmallow.h?at=master). You might not know specifically how or where to get these things, but you know what it takes to make hot cocoa. Maybe it would play out like this.

```objective-c
    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];

    [config registerComponent:@protocol(HotWaterSource) initsWith:
     ^{
         return [[Kettle alloc] init];
     }];

    [config registerComponent:@protocol(Topping) initsWith:
     ^{
         return [[Marshmallow alloc] init];
     }];

    [config registerComponent:@protocol(Mix)
                 dependentOn1:@protocol(Topping)
                    initsWith:
     ^(id<Topping> topping){
         return [[CocoaPowder alloc] initWithTopping:topping];
     }];

    [config registerComponent:@protocol(LiquidVessel)
                 dependentOn1:@protocol(HotWaterSource)
                         and2:@protocol(Mix)
                    initsWith:
     ^(id<HotWaterSource> source, id<Mix> mix){
         return [[CocoaMug alloc] initWithHotWater:source andMixture:mix];
     }];

    [config start:YES]; // Yes for auto-resolve when starting
```
The above might happen inside of some cocoa configuration module, and the below could be happening in some client code.
```objective-c
    id<LiquidVessel> myMug =
        [config resolveComponent:@protocol(LiquidVessel)];

    // Pass myMug to a CocoaDrinker

...

    // Later on inside of CocoaDrinker

    [myMug drink:20];
    [myMug checkAmount];
    [myMug drink:30];
    [myMug checkAmount];
```
When the above code is run, its output is like so
```
// The following messages are printed from objects implementing
// CCTStartable start when start is called on the container.
Boiling water to 100 degrees C.
Creating CocoaPowder mix with Marshmallow topping
Shovel three tablespoons of mixture.
Pouring a cup of hot water.
Mug is filled to 250 ml of hot Cocoa.

// These messages are printed explicitly by call
Drinking 20 ml from the mug
There is 230 ml of cocoa left in the mug
Drinking 30 ml from the mug
There is 200 ml of cocoa left in the mug

// The following dealloc print messages are triggered
// when the container is cleaned after leaving scope
// of an autoreleasepool
Someone left this 200 ml full mug here. I will just pour it out.
This cocoa powder has coagulated at the bottom.
This marshmallow is so soggy that it has nearly turned into liquid.
This water got cold and looks old. I will dump it out.

// Printed after autoreleasepool, before end of scope
Before method's local scope end.
```
### Examples By the Block ###

To create a Cocoatainer container
```objective-c
#import "CCTCocoatainer.h"
...

    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];
```

To register a class (concrete) with no dependencies to an initializer block
```objective-c
    [config registerComponent:[MyClass class] initsWith:
     ^{
         return [[MyClass alloc] init];
     }];
```

To do the above with 1 dependency it would look like
```objective-c
    [config registerComponent:[DependsOn1 class]
                 dependentOn1:[SomeClass class]
                    initsWith:^(SomeClass* d1)
     {
         return [[DependsOn1 alloc] initWithD1:d1];
     }];
```

To register a pre-allocated instance of a class
```objective-c
    MyClass* myClass = [[MyClass alloc] init];
    [config registerComponent:[MyClass class]
                 withInstance:myClass];
```

To resolve an instance of a registered class
```objective-c
    MyClass* testObject = [config resolveComponent:[MyClass class]];
```

To register a protocol (abstract) with 2 dependencies to an initializer block
```objective-c
    [config registerComponent:@protocol(MyProtocol)
                 dependentOn1:@protocol(ProtocolD1)
                         and2:@protocol(ProtocolD2)
                    initsWith:^(id<ProtocolD1> d1, id<ProtocolD2> d2)
     {
         return [[MyClass2Deps alloc] initWithD1:d1 andD2:d2];
     }];
```

To resolve a component by protocol
```objective-c
    id<MyProtocol> myMug =
        [config resolveComponent:@protocol(MyProtocol)];
```

A class' dependents can be protocols, and a protocol's dependents can be classes. Here's what 6 class dependencies for a protocol looks like
```objective-c
    [config registerComponent:@protocol(IDependsOnMultiple)
                 dependentOn1:[MyClassA class]
                         and2:[MyClassB class]
                         and3:[MyClassC class]
                         and4:[MyClassD class]
                         and5:[MyClassE class]
                         and6:[MyClassF class]
                    initsWith:
     ^(MyClassA* d1, MyClassB* d2, MyClassC* d3,
       MyClassD* d4, MyClassE* d5, MyClassF* d6)
     {
         // This init takes nil-terminated VA args
         return [[DependsOnMultiple alloc] initWithDependencies:
                 d1, d2, d3, d4, d5, d6, nil];
     }];
```

This example below is container scope nesting. Note, that an inner (descendant) container can resolve objects from the outer (ancestor) containers, but the outer containers cannot resolve objects from the inner. This is because the outer scope is wider than inner scopes, so there is no guarantee the inner scope is active.
```objective-c
    CCTCocoatainer* outerScope = [[CCTCocoatainer alloc] init];

    [outerScope registerComponent:@protocol(ILog)
                        initsWith:^{
                            return [[ArrayLog alloc] init];
                        }];

    @autoreleasepool
    {
        CCTCocoatainer* innerScope = [[CCTCocoatainer alloc] init];
        [innerScope addParent:outerScope];

        [innerScope registerComponent:@protocol(ILoggerA)
                         dependentOn1:@protocol(ILog)
                            initsWith:^(id<ILog> log){
                                return [[DescopeLoggerA alloc] initWithLog:log];
                            }];

        id testObject = [innerScope resolveComponent:@protocol(ILoggerA)];
    } // End of inner scope

    // ILoggerA will scope out and print a dealloc message here, while ILog is still in scope
```

### CocoaMug Example in Swift ###
```
import Cocoatainer
...
        var container = CCTCocoatainer()

        var phws: AnyObject! = NSObject.abstractId(HotWaterSource.self)
        var ptop: AnyObject! = NSObject.abstractId(Topping.self)
        var pmix: AnyObject! = NSObject.abstractId(Mixture.self)
        var pmug: AnyObject! = NSObject.abstractId(LiquidVessel.self)

        container.registerComponent(phws, initsWith:
            { () -> AnyObject in
                Kettle()
            })

        container.registerComponent(ptop, initsWith:
            { () -> AnyObject in
                Marshmallow()
            })

        container.registerComponent(pmix,
            dependentOn1: ptop,
            initsWith:
            { (top: AnyObject!) -> AnyObject! in
                CocoaPowder(topping: top as! Topping)
            })

        container.registerComponent(pmug!,
            dependentOn1: phws,
            and2: pmix)
            { (source: AnyObject!, mix: AnyObject!) -> AnyObject! in
                CocoaMug(source: source as! HotWaterSource,
                    mixture: mix as! Mixture)
            }

        container.start(true)

        var mug: LiquidVessel =
            container.resolveComponent(pmug) as! LiquidVessel

        mug.drink(25)
        mug.checkAmount()
        mug.drink(25)
        mug.checkAmount()
```
### Getting Familiar ###

Before using Cocoatainer in your own project, you may want to familiarize yourself with the framework. The following will help getting the Cocoatainer test harness and example code running.

* Download the repo
* In the root folder, open the Cocoatainer.xcworkspace file in XCode.
* Under the CocoatainerExample project, the example code is called in the main.m file. Running it will print to the Console. Look at the CocoaMug example for practical uses of the container.
* Under the CocoatainerGuiExample project, this example code will run a GUI application which contains buttons to control the lifecycle of an inner container. There is an outer container owned by IB which provides View dependencies to the inner container.
* Under the Cocoatainer project, in the CocoatainerTests folder there are several files, each containing several unit tests on the container. Many of the types are only setup for the purpose of testing the container, and may not be setup with the best practices in mind.

### License ###

Copyright (C)2015 Jeffrey Bakker. All rights reserved.  
Released under the MIT license (see LICENSE.md for full text).

### Contact ###

Jeffrey Bakker <jeffrey at seatoskyware dot com>