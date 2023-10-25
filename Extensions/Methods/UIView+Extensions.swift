//
//  UIView+MenuTrigger.swift
//  UIExtensions
//
//  Created by 李文康 on 2018/7/13.
//  Copyright © 2018 FunctionMaker. All rights reserved.
//

// MARK: - Scene
extension Zonable where Base: UIView {
    /// Get view controller who contains itself by response chain.
    var scene: UIViewController? {
        var nextResponder: UIResponder? = base.next
        while nextResponder != nil {
            if let result = nextResponder as? UIViewController {
                return result
            }
            nextResponder = nextResponder?.next
        }
        return nil
    }
}

// MARK: - Menu
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
    var x: CGFloat {
        get { base.frame.origin.x }
        set { base.frame.origin.x = newValue }
    }

    var y: CGFloat {
        get { base.frame.origin.y }
        set { base.frame.origin.y = newValue }
    }

    var origin: CGPoint {
        get { base.frame.origin }
        set { base.frame.origin = newValue }
    }

    var width: CGFloat {
        get { base.frame.size.width }
        set { base.frame.size.width = newValue }
    }

    var height: CGFloat {
        get { base.frame.size.height }
        set { base.frame.size.height = newValue }
    }

    var size: CGSize {
        get { base.frame.size }
        set { base.frame.size = newValue }
    }

    var top: CGFloat {
        get { y }
        set { y = newValue }
    }

    var leading: CGFloat {
        get { x }
        set { x = newValue }
    }

    var bottom: CGFloat {
        get { y + height }
        set {
            var frame = base.frame
            frame.origin.y = newValue - frame.size.height
            base.frame = frame
        }
    }

    var trailing: CGFloat {
        get { x + width }
        set {
            var frame = base.frame
            frame.origin.x = newValue - frame.size.width
            base.frame = frame
        }
    }
}
