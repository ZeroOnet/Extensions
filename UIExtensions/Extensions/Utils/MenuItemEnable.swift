//
//  MenuItemEnable.swift
//  UIExtensions
//
//  Created by 李文康 on 2018/7/12.
//  Copyright © 2018 FunctionMaker. All rights reserved.
//

import Foundation

/// menu item enable protocol
protocol MenuItemEnable {
    var title: String { get }
    var action: Selector { get }
}

/// defalut menu item type, you can custom yours type
struct MenuItem: MenuItemEnable {
    var title: String {
        return _title
    }
    
    var action: Selector {
        return _action
    }
    
    private let _title: String
    private let _action: Selector
    
    init(title: String, action: Selector) {
        self._title = title
        self._action = action
    }
}
