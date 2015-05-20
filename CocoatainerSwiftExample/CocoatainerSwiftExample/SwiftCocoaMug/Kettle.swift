//
//  Kettle.swift
//  CocoatainerSwiftExample
//
//  Created by Jeffrey Bakker on 2015-05-20.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

import Cocoatainer

class Kettle: NSObject, HotWaterSource, CCTStartable
{
    let FullCup = 250

    deinit
    {
        println("This water got cold and looks old. I will dump it out.")
    }

    func start()
    {
        heat()
    }

    func heat()
    {
        println("Boiling water to 100 degrees C.")
    }

    func pourCup() -> Int
    {
        println("Pouring a cup of hot water.")
        return FullCup
    }
}
