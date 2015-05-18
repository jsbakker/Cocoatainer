# README #

Welcome to the Cocoatainer project. This project is aimed at providing Objective-C developers with an iOS framework for [Dependency Injection](http://en.wikipedia.org/wiki/Dependency_injection) / [Inversion of Control](http://en.wikipedia.org/wiki/Inversion_of_control). 
 
Cocoatainer provides an IoC container with constructor injection. What makes it different is that it supports registering components either by abstract (protocol) or by concrete type (class), although there is also a strict, abstract-only version as well. The container also supports:

* Adding components by block (anonymous function) with dependencies
* Adding components by pre-allocated instance
* Multiple dependencies, auto-resolving when needed
* Nested dependencies, auto-resolving when needed
* Nested containers (with auto-resolving dependencies from parent)
* Startable (with option of auto-resolution of objects not referenced outside the container, i.e. object lives solely in the container)

The Cocoatainer framework code is covered by literally dozens of tests around all of the above scenarios. 

### Example Usages ###

To create a Cocoatainer container
```objective-c
#import "CCTCocoatainer.h"
...

    CCTCocoatainer* config = [[CCTCocoatainer alloc] init];
```

To register a class (concrete) with no dependencies to a block
```objective-c
    [config registerComponent:[MyClass class] initsWith:
     ^{
         return [[MyClass alloc] init];
     }];
```

To register an pre-allocated instance of a class
```objective-c
    MyClass* myClass = [[MyClass alloc] init];
    [config registerComponent:[MyClass class]
                 withInstance:myClass];
```

To resolve an instance of a registered class
```objective-c
    MyClass* testObject = [config resolveComponent:[MyClass class]];
```

To register a protocol (abstract) with dependencies to a block
```objective-c
    [config registerComponent:@protocol(MyProtoc)
                 dependentOn1:@protocol(IDependsOn1A)
                         and2:@protocol(INoDepsA)
                    initsWith:^(id<IDependsOn1A> d1, id<INoDepsA> d2)
     {
         return [[DependsOn2C alloc] initWithD1:d1 and2:d2];
     }];
```
### Getting Familiar ###

Before using Cocoatainer in your own project, you may want to familiarize yourself with the framework. The following will help getting the Cocoatainer test harness and example code running.

* Download the repo
* In the root folder, open the Cocoatainer.xxworkspace file in XCode.
* Under the CocoatainerExample project, the example code is called my the AppDelegate's application:didFinisLaunching: method. Look at the CocoaMug example for practical uses of the container.
* Under the Cocoatainer project, in the CocoatainerTests folder there are several files, each containing several unit tests on the container. Many of the types are only setup for the purpose of testing the container, and may not be setup with the best practices in mind.

### License ###

Copyright (C)2015 Jeffrey Bakker. All rights reserved.  
Released under the MIT license (see LICENSE.md for full text).

### Contact ###

Jeffrey Bakker <jeffrey at seatoskyware dot com>