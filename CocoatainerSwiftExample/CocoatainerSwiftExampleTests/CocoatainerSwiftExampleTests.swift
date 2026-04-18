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

        let container = CCTCocoatainer()

        let phws = NSObject.protocol(asId: HotWaterSource.self) as AnyObject

        container.registerComponent(phws, initsWith: { Kettle() })

        XCTAssertNotNil(container.resolveComponent(phws) as? HotWaterSource, "HotWaterSource not nil")
    }

    func testRegisterClassWithClosure() {

        let container = CCTCocoatainer()

        container.registerComponent(Kettle.self, initsWith: { Kettle() })

        XCTAssertNotNil(container.resolveComponent(Kettle.self) as? Kettle, "Kettle not nil")
    }

    func testRegisterProtocolWithInstance() {

        let container = CCTCocoatainer()

        let phws = NSObject.protocol(asId: HotWaterSource.self) as AnyObject

        container.registerComponent(phws, withInstance: Kettle())

        XCTAssertNotNil(container.resolveComponent(phws) as? HotWaterSource, "HotWaterSource not nil")
    }

    func testRegisterClassWithInstance() {

        let container = CCTCocoatainer()

        container.registerComponent(Kettle.self, withInstance: Kettle())

        XCTAssertNotNil(container.resolveComponent(Kettle.self) as? Kettle, "Kettle not nil")
    }

    func testNestedScope() {

        let ptop = NSObject.protocol(asId: Topping.self) as AnyObject
        let pmix = NSObject.protocol(asId: Mixture.self) as AnyObject

        let outerScope = CCTCocoatainer()

        outerScope.registerComponent(ptop, withInstance: Marshmallow())

        autoreleasepool {

            let innerScope = CCTCocoatainer()
            innerScope.addParent(outerScope)

            innerScope.registerComponent(pmix,
                dependentOn1: ptop,
                initsWith: { top in
                    CocoaPowder(topping: top as! Topping)
                })

            let mixture = innerScope.resolveComponent(pmix) as! Mixture

            XCTAssertNotNil(mixture, "Mixture resolved.")
        }
    }

    func testNestedScopeThreeGenerations() {

        let phws = NSObject.protocol(asId: HotWaterSource.self) as AnyObject
        let ptop = NSObject.protocol(asId: Topping.self) as AnyObject
        let pmix = NSObject.protocol(asId: Mixture.self) as AnyObject
        let pmug = NSObject.protocol(asId: LiquidVessel.self) as AnyObject

        let outerScope = CCTAbstractCocoatainer()

        outerScope.registerComponent(phws, withInstance: Kettle())
        outerScope.registerComponent(ptop, withInstance: Marshmallow())

        autoreleasepool {

            let middleScope = CCTAbstractCocoatainer()
            middleScope.addParent(outerScope)

            middleScope.registerComponent(pmix,
                dependentOn1: ptop,
                initsWith: { top in
                    CocoaPowder(topping: top as! Topping)
                })

            autoreleasepool {

                let innerScope = CCTAbstractCocoatainer()
                innerScope.addParent(middleScope)

                innerScope.registerComponent(pmug,
                    dependentOn1: phws,
                    and2: pmix,
                    initsWith: { source, mix in
                        CocoaMug(source: source as! HotWaterSource,
                            mixture: mix as! Mixture)
                    })

                let mug = innerScope.resolveComponent(pmug) as! LiquidVessel

                XCTAssertNotNil(mug, "LiquidVessel resolved.")
            }
        }
    }
}
