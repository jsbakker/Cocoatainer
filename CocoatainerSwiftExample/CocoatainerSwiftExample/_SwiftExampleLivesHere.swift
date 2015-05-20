//
//  _SwiftExampleLivesHere.swift
//  CocoatainerSwiftExample
//
//  Created by Jeffrey Bakker on 2015-05-20.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

import Cocoatainer

class _SwiftExampleLivesHere: NSObject
{
    static func CocoatainerExample()
    {
        var container = CCTCocoatainer()

        // Works (overload to Protocol* in Obj-C API)
//        container.registerContract(HotWaterSource.self, initsWith:                         { () -> AnyObject in
//                return Kettle()
//            })

        // Throws on type check
//        container.registerComponent(HotWaterSource.self as? AnyObject, initsWith:                         { () -> AnyObject in
//                return Kettle()
//            })

        // Works (concrete type)
        container.registerComponent(Kettle.self, initsWith:
            { () -> AnyObject in
                return Kettle()
            })

        container.start(true)
    }
}
