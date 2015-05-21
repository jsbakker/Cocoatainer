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

//        var phws : Protocol! = HotWaterSource.self
//        var ptop : Protocol! = Topping.self
//
//        container.registerComponent(phws as! AnyObject!, initsWith:
//            { () -> AnyObject in
//                Kettle()
//        })

        // Works (concrete type)
        container.registerComponent(Kettle.self, initsWith:
            { () -> AnyObject in
                Kettle()
            })

        container.registerComponent(Marshmallow.self, initsWith:
            { () -> AnyObject in
                Marshmallow()
            })

        container.registerComponent(CocoaPowder.self,
            dependentOn1: Marshmallow.self,
            initsWith:
            { (top: AnyObject!) -> AnyObject! in
                CocoaPowder(topping: top as! Topping)
            })

        container.registerComponent(CocoaMug.self,
            dependentOn1: Kettle.self,
            and2: CocoaPowder.self)
            { (source: AnyObject!, mix: AnyObject!) -> AnyObject! in
                CocoaMug(source: source as! HotWaterSource,
                    mixture: mix as! Mixture)
            }

        container.start(true)

        var mug: LiquidVessel =
            container.resolveComponent(CocoaMug.self) as! LiquidVessel

        mug.drink(25)
        mug.checkAmount()
        mug.drink(25)
        mug.checkAmount()
    }
}
