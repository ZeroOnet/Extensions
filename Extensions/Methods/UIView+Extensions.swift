//
//  UIView+MenuTrigger.swift
//  UIExtensions
//
//  Created by 李文康 on 2018/7/13.
//  Copyright © 2018 FunctionMaker. All rights reserved.
//

/// menu item enable protocol
protocol MenuItemEnable {
    var title: String { get }
    var action: Selector { get }
}

extension Zonable where Base: UIView {
    /// Make menu controller be available.
    /// - Warning: view's canBecomeFirstResponder shoud be true, superview not be nil.
    func asMenuTrigger(_ menuItems: [MenuItemEnable]) {
        guard base.canBecomeFirstResponder, let superview = base.superview else { return }
        _ = base.becomeFirstResponder()
        let menuController = UIMenuController.shared
        menuController.setTargetRect(base.frame, in: superview)
        menuController.menuItems = menuItems.map {
            UIMenuItem(title: $0.title, action: $0.action)
        }
        menuController.setMenuVisible(true, animated: true)
    }
}

// MARK: - Shortcuts of frame
extension Zonable where Base: UIView {
    var x: CGFloat { base.frame.origin.x }
    var y: CGFloat { base.frame.origin.y }

    var width: CGFloat { base.bounds.width }
    var height: CGFloat { base.bounds.height }

    var origin: CGPoint { base.frame.origin }
    var size: CGSize { base.bounds.size }

    func setX(_ x: CGFloat) { base.frame.origin.x = x }
    func setY(_ y: CGFloat) { base.frame.origin.y = y }

    func setWidth(_ width: CGFloat) { base.frame.size.width = width }
    func setHeight(_ height: CGFloat) { base.frame.size.height = height }

    func setOrigin(_ origin: CGPoint) { base.frame.origin = origin }
    func setSize(_ size: CGSize) { base.frame.size = size }
}
