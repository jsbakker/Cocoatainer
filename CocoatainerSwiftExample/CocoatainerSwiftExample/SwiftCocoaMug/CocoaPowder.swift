//
//  CocoaPowder.swift
//  CocoatainerSwiftExample
//
//  Created by Jeffrey Bakker on 2015-05-20.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

import Cocoatainer

public class CocoaPowder: NSObject, Mixture, CCTStartable
{
    var topping: Topping

    public init(topping: Topping)
    {
        self.topping = topping
    }

    deinit
    {
        print("This cocoa powder has coagulated at the bottom.")
    }

    public func start()
    {
        print("Creating \(String(describing: type(of: self))) mix with \(topping.name()) topping.")
    }

    public func shovel()
    {
        print("Shovel three tablespoons of mixture.")
    }
}
