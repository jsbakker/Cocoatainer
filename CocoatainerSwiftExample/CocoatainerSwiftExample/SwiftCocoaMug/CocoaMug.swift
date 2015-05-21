//
//  CocoaMug.swift
//  CocoatainerSwiftExample
//
//  Created by Jeffrey Bakker on 2015-05-20.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

import Cocoatainer

class CocoaMug: NSObject, LiquidVessel, CCTStartable
{
    var source: HotWaterSource
    var mixture: Mixture

    var millilitres: Int

    init(source: HotWaterSource, mixture: Mixture)
    {
        self.source = source
        self.mixture = mixture
        self.millilitres = 0
    }

    deinit
    {
        println("Someone left this \(millilitres) ml full mug here. I will just pour it out.")
    }

    func start()
    {
        fill()
    }

    func fill()
    {
        mixture.shovel()
        millilitres = source.pourCup()
        println("Mug is filled to \(millilitres) ml of hot Cocoa.")
    }

    func drink(amount: Int)
    {
        println("Drinking \(millilitres) ml from the mug.")
        millilitres -= amount
    }

    func checkAmount()
    {
        println("There is \(millilitres) ml of cocoa left in the mug.")
    }
}
