//
//  UIView+MenuTrigger.swift
//  UIExtensions
//
//  Created by 李文康 on 2018/7/13.
//  Copyright © 2018 FunctionMaker. All rights reserved.
//

// MARK: - Conform Compatible
extension UIView {
    // fix: Cannot assign to property: 'self' is immutable
    var zon: Zonable<UIView> {
        get { Zonable(self) }
        set {} // swiftlint:disable:this unused_setter_value
    }
}

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

// MARK: - Hotspot
extension Zonable where Base: UIView {
    /// Specify minimum positive hotspot size. View will expand its bounds for Hit-Test equally to fit it.
    var minimumSize: CGSize? {
        get { _hotspot.minimumSize }
        set { _hotspot.minimumSize = newValue }
    }

    /// Expand(negative value) or shrink(positive value) extra hotspot area.
    /// View will expand or shrink its bounds for Hit-Test to fit it.
    var extraArea: UIEdgeInsets? {
        get { _hotspot.extraArea }
        set { _hotspot.extraArea = newValue }
    }

    private var _hotspot: UIView._Hotspot {
        if let existed = base._hotspot { return existed }
        let new = UIView._Hotspot(view: base)
        base._hotspot = new
        return new
    }
}

extension UIView {
    fileprivate var _hotspot: _Hotspot? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.hotspot) as? _Hotspot
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.hotspot, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    fileprivate struct AssociatedKeys {
        static var hotspot: UInt8 = 0
    }

    fileprivate class _Hotspot {
        var minimumSize: CGSize?
        var extraArea: UIEdgeInsets?
        weak var view: UIView?
        init(view: UIView) {
            self.view = view

            let pointInsideBlock: @convention(block)(AspectInfo) -> Void = { [weak self] info in
                guard
                    let point = info.arguments().first as? CGPoint,
                    let bounds = self?.view?.bounds
                else { return }

                let invocation = info.originalInvocation()

                if let minimumSize = self?.minimumSize {
                    let size = bounds.size
                    let expandWidth = size.width - minimumSize.width
                    let expandHeight = size.height - minimumSize.height

                    var insets: UIEdgeInsets = .zero
                    if expandWidth < 0 {
                        insets.top = expandHeight / 2
                        insets.bottom = insets.top
                    }
                    if expandHeight < 0 {
                        insets.left = expandWidth / 2
                        insets.right = insets.left
                    }
                    var result = bounds.inset(by: insets).contains(point)
                    invocation?.setReturnValue(&result)
                } else {
                    var result = bounds.inset(by: self?.extraArea ?? .zero).contains(point)
                    invocation?.setReturnValue(&result)
                }
            }
            let viewClass = type(of: view)
            _ = try? view.aspect_hook(
                #selector(viewClass.point(inside:with:)),
                with: .positionInstead,
                usingBlock: pointInsideBlock
            )
        }
    }
}
