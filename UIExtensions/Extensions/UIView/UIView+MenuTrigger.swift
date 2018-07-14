//
//  UIView+MenuTrigger.swift
//  UIExtensions
//
//  Created by 李文康 on 2018/7/13.
//  Copyright © 2018 FunctionMaker. All rights reserved.
//

import UIKit

extension UIView {
    func asMenuTrigger(_ menuItems: [MenuItemEnable]) {
        // become first responder is the premise of show menu controller
        _ = becomeFirstResponder()
        let menuController = UIMenuController.shared
        if let selfSuperview = superview {
            menuController.setTargetRect(frame, in: selfSuperview)
            menuController.menuItems = menuItems.map {
                UIMenuItem(title: $0.title, action: $0.action)
            }
            menuController.setMenuVisible(true, animated: true)
        } else {
            debugPrint("invalid superview contains \(self)")
        }
    }
    
    open override var canBecomeFirstResponder: Bool {
        return true
    }
}
