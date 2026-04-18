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

        // If there's a nicer way to turn a Swift Protocol into a Protocol!
        // and cast again into an AnyObject! so it can be passed to Obj-C
        // as an id then we can get rid of this ugly bit.
        var phws: AnyObject! = NSObject.protocol(asId: HotWaterSource.self) as AnyObject
        var ptop: AnyObject! = NSObject.protocol(asId: Topping.self) as AnyObject
        var pmix: AnyObject! = NSObject.protocol(asId: Mixture.self) as AnyObject
        var pmug: AnyObject! = NSObject.protocol(asId: LiquidVessel.self) as AnyObject


        container.registerComponent(phws, withInstance: Kettle())

        container.registerComponent(ptop, withInstance: Marshmallow())

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
    }
}
