//
//  CocoatainerSwiftExampleTests.swift
//  CocoatainerSwiftExampleTests
//
//  Created by Jeffrey Bakker on 2015-05-20.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

import Cocoatainer
import CocoatainerSwiftExample
import XCTest

class CocoatainerSwiftExampleTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRegisterProtocolWithClosure() {

        var container = CCTCocoatainer()

        var phws: AnyObject! = NSObject.protocolAsId(HotWaterSource.self)

        container.registerComponent(phws, initsWith:
            { () -> AnyObject in
                Kettle()
        })

        var hws = container.resolveComponent(phws) as! HotWaterSource!

        XCTAssertTrue(hws != nil, "HotWaterSource not nil")
    }

    func testRegisterClassWithClosure() {

        var container = CCTCocoatainer()

        container.registerComponent(Kettle.self, initsWith:
            { () -> AnyObject in
                Kettle()
        })

        var k = container.resolveComponent(Kettle.self) as! Kettle!

        XCTAssertTrue(k != nil, "Kettle not nil")
    }

    func testRegisterProtocolWithInstance() {

        var container = CCTCocoatainer()

        var phws: AnyObject! = NSObject.protocolAsId(HotWaterSource.self)

        container.registerComponent(phws, withInstance: Kettle())

        var hws = container.resolveComponent(phws) as! HotWaterSource!

        XCTAssertTrue(hws != nil, "HotWaterSource not nil")
    }

    func testRegisterClassWithInstance() {

        var container = CCTCocoatainer()

        container.registerComponent(Kettle.self, withInstance: Kettle())

        var k = container.resolveComponent(Kettle.self) as! Kettle!
        
        XCTAssertTrue(k != nil, "Kettle not nil")
    }

    func testNestedScope() {

        var ptop: AnyObject! = NSObject.protocolAsId(Topping.self)
        var pmix: AnyObject! = NSObject.protocolAsId(Mixture.self)

        var outerScope = CCTCocoatainer()

        outerScope.registerComponent(ptop, withInstance: Marshmallow())

        autoreleasepool {

            var innerScope = CCTCocoatainer()
            innerScope.addParent(outerScope)

            innerScope.registerComponent(pmix,
                dependentOn1: ptop,
                initsWith:
                { (top: AnyObject!) -> AnyObject! in
                    CocoaPowder(topping: top as! Topping)
                })

            var mixture =
                innerScope.resolveComponent(pmix) as! Mixture

            XCTAssertNotNil(mixture, "Mixture resolved.")
        }
    }

    func testNestedScopeThreeGenerations() {

        var phws: AnyObject! = NSObject.protocolAsId(HotWaterSource.self)
        var ptop: AnyObject! = NSObject.protocolAsId(Topping.self)
        var pmix: AnyObject! = NSObject.protocolAsId(Mixture.self)
        var pmug: AnyObject! = NSObject.protocolAsId(LiquidVessel.self)

        var outerScope = CCTAbstractCocoatainer()

        outerScope.registerComponent(phws, withInstance: Kettle())
        outerScope.registerComponent(ptop, withInstance: Marshmallow())

        autoreleasepool {

            var middleScope = CCTAbstractCocoatainer()
            middleScope.addParent(outerScope)

            middleScope.registerComponent(pmix,
                dependentOn1: ptop,
                initsWith:
                { (top: AnyObject!) -> AnyObject! in
                    CocoaPowder(topping: top as! Topping)
            })

            autoreleasepool {

                var innerScope = CCTAbstractCocoatainer()
                innerScope.addParent(middleScope)

                innerScope.registerComponent(pmug!,
                    dependentOn1: phws,
                    and2: pmix)
                    { (source: AnyObject!, mix: AnyObject!) -> AnyObject! in
                        CocoaMug(source: source as! HotWaterSource,
                            mixture: mix as! Mixture)
                }

                var mug: LiquidVessel =
                    innerScope.resolveComponent(pmug) as! LiquidVessel

                XCTAssertNotNil(mug, "LiquidVessel resolved.")
            }
        }
    }
}
