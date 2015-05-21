//
//  LiquidVessel.swift
//  CocoatainerSwiftExample
//
//  Created by Jeffrey Bakker on 2015-05-20.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

import Foundation

@objc protocol LiquidVessel
{
    func fill()
    func drink(amount: Int)
    func checkAmount()
}