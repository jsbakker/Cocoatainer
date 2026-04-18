//
//  CocoaMug.swift
//  CocoatainerSwiftExample
//
//  Created by Jeffrey Bakker on 2015-05-20.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

import Cocoatainer

public class CocoaMug: NSObject, LiquidVessel, CCTStartable
{
    var source: HotWaterSource
    var mixture: Mixture

    var millilitres: Int

    public init(source: HotWaterSource, mixture: Mixture)
    {
        self.source = source
        self.mixture = mixture
        self.millilitres = 0
    }

    deinit
    {
        print("Someone left this \(millilitres) ml full mug here. I will just pour it out.")
    }

    public func start()
    {
        fill()
    }

    public func fill()
    {
        mixture.shovel()
        millilitres = source.pourCup()
        print("Mug is filled to \(millilitres) ml of hot Cocoa.")
    }

    public func drink(_ amount: Int)
    {
        print("Drinking \(millilitres) ml from the mug.")
        millilitres -= amount
    }

    public func checkAmount()
    {
        print("There is \(millilitres) ml of cocoa left in the mug.")
    }
}
