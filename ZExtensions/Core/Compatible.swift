//
//  Compatible.swift
//  UIExtensions
//
//  Created by 李文康 on 2019/7/26.
//  Copyright © 2019 FunctionMaker. All rights reserved.
//

@_exported import UIKit

protocol Compatible {
    associatedtype CompatibleType
    static var zon: Zonable<CompatibleType>.Type { get }
    var zon: Zonable<CompatibleType> { get }
}

extension Compatible {
    static var zon: Zonable<Self>.Type { Zonable<Self>.self }
    var zon: Zonable<Self> { Zonable(self) }
}

struct Zonable<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: Compatible {}
