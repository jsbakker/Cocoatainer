//
//  Kettle.swift
//  CocoatainerSwiftExample
//
//  Created by Jeffrey Bakker on 2015-05-20.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

import Cocoatainer

public class Kettle: NSObject, HotWaterSource, CCTStartable
{
    let FullCup = 250

    deinit
    {
        print("This water got cold and looks old. I will dump it out.")
    }

    public func start()
    {
        heat()
    }

    public func heat()
    {
        print("Boiling water to 100 degrees C.")
    }

    public func pourCup() -> Int
    {
        print("Pouring a cup of hot water.")
        return FullCup
    }
}
