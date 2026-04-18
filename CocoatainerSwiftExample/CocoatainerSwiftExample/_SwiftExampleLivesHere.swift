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
        let container = CCTCocoatainer()

        let phws = NSObject.protocol(asId: HotWaterSource.self) as AnyObject
        let ptop = NSObject.protocol(asId: Topping.self) as AnyObject
        let pmix = NSObject.protocol(asId: Mixture.self) as AnyObject
        let pmug = NSObject.protocol(asId: LiquidVessel.self) as AnyObject

        container.registerComponent(phws, withInstance: Kettle())

        container.registerComponent(ptop, withInstance: Marshmallow())

        container.registerComponent(pmix,
            dependentOn1: ptop,
            initsWith: { top in
                CocoaPowder(topping: top as! Topping)
            })

        container.registerComponent(pmug,
            dependentOn1: phws,
            and2: pmix,
            initsWith: { source, mix in
                CocoaMug(source: source as! HotWaterSource,
                    mixture: mix as! Mixture)
            })

        container.start(true)

        let mug = container.resolveComponent(pmug) as! LiquidVessel

        mug.drink(25)
        mug.checkAmount()
        mug.drink(25)
        mug.checkAmount()
    }
}
