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

A class' dependents can be protocols, and a protocol's dependents can be classes. Here's what 6 dependencies looks like
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