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
    static var zon: Zonable<CompatibleType>.Type { get set }
    var zon: Zonable<CompatibleType> { get set }
}

extension Compatible {
    static var zon: Zonable<Self>.Type {
        get { Zonable<Self>.self }
        set {} // swiftlint:disable:this unused_setter_value
    }
    var zon: Zonable<Self> {
        get { Zonable(self) }
        set {} // swiftlint:disable:this unused_setter_value
    }
}

struct Zonable<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: Compatible {}
