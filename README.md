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

### How do I get set up? ###

* Summary of set up
* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact