//
//  Marshmallow.swift
//  CocoatainerSwiftExample
//
//  Created by Jeffrey Bakker on 2015-05-20.
//  Copyright (c) 2015 Jeffrey Bakker. All rights reserved.
//

import Foundation

public class Marshmallow: NSObject, Topping
{
    public func name() -> String
    {
        return "\(_stdlib_getDemangledTypeName(self))"
    }
}
