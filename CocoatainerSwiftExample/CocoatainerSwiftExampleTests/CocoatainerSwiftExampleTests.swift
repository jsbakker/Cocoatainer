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
    
    func testRegisterByProtocol() {

        var container = CCTCocoatainer()

        var phws: AnyObject! = NSObject.protocolAsId(HotWaterSource.self)

        container.registerComponent(phws, initsWith:
            { () -> AnyObject in
                Kettle()
        })

        var hws = container.resolveComponent(phws) as! HotWaterSource!

        XCTAssertTrue(hws != nil, "HotWaterSource not nil")
    }

    func testRegisterByClass() {

        var container = CCTCocoatainer()

        container.registerComponent(Kettle.self, initsWith:
            { () -> AnyObject in
                Kettle()
        })

        var k = container.resolveComponent(Kettle.self) as! Kettle!

        XCTAssertTrue(k != nil, "Kettle not nil")
    }
}
