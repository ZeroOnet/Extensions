//
//  UILabel+Copy.swift
//  UIExtensions
//
//  Created by 李文康 on 2018/7/10.
//  Copyright © 2018 FunctionMaker. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// let UILabel instance can be copyable
    func copyable() {
        isUserInteractionEnabled = true
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: #selector(copyAction))
        addGestureRecognizer(tapGestureRecog)
    }
    
    /// this system method will be called when default copy action occured
    open override func copy(_ sender: Any?) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }
    
    open override var canBecomeFirstResponder: Bool {
        return true
    }
}

private extension UILabel {
    @objc private func copyAction() {
        _ = becomeFirstResponder()
        let menuController = UIMenuController.shared
        if let selfSuperview = superview {
            menuController.setTargetRect(frame, in: selfSuperview)
            menuController.setMenuVisible(true, animated: true)
        } else {
            debugPrint("invalid superview")
        }
    }
}
