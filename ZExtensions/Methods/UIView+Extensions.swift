//
//  UIView+MenuTrigger.swift
//  UIExtensions
//
//  Created by 李文康 on 2018/7/13.
//  Copyright © 2018 FunctionMaker. All rights reserved.
//

// MARK: - Highlighted
extension Zonable where Base: UIView {
    /// Make view highlighted like UIButton when you click.
    var isHighlightEnabled: Bool {
        get {
            base.gestureRecognizers?.contains(where: { $0 is __Zon_GR }) == true
        }
        set {
            if !newValue {
                base.gestureRecognizers?.removeAll(where: { $0 is __Zon_GR })
            } else {
                guard !isHighlightEnabled else { return }
                var modified = false
                if !base.isUserInteractionEnabled {
                    base.isUserInteractionEnabled = true
                    modified = true
                }
                base.addGestureRecognizer(__Zon_GR(modified: modified))
            }
        }
    }

    fileprivate class __Zon_GR: UIGestureRecognizer, UIGestureRecognizerDelegate {
        var stashed: CGFloat = 1
        let modified: Bool
        init(modified: Bool) {
            self.modified = modified
            super.init(target: nil, action: nil)
            delegate = self
            delaysTouchesEnded = false
        }

        deinit { if modified { view?.isUserInteractionEnabled = false } }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
            super.touchesBegan(touches, with: event)
            _doIfNeeded { stashed = $0.alpha; $0.alpha = stashed * 0.5 }
        }

        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
            super.touchesCancelled(touches, with: event)
            _recover()
        }

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
            super.touchesEnded(touches, with: event)
            _recover()
        }

        func gestureRecognizer(
            _ gestureRecognizer: UIGestureRecognizer,
            shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
            true
        }

        private func _doIfNeeded(_ work: (UIView) -> Void) {
            guard let view else { return }
            work(view)
        }

        private func _recover() {
            _doIfNeeded { $0.alpha = stashed; stashed = 1 }
        }
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

    private var _hotspot: UIView.__Zon_Hotspot {
        if let existed = base.__zon_hotspot { return existed }
        let new = UIView.__Zon_Hotspot(view: base)
        base.__zon_hotspot = new
        return new
    }
}

extension UIView {
    fileprivate var __zon_hotspot: __Zon_Hotspot? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.hotspot) as? __Zon_Hotspot
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.hotspot, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    fileprivate class __Zon_Hotspot {
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

protocol GradationSettable: AnyObject {
    var locations: [CGFloat] { get set }
    var colors: [UIColor] { get set }
    var startPoint: CGPoint { get set }
    var endPoint: CGPoint { get set }
}

// MARK: - Gradient Layer
extension Zonable where Base: UIView {
    var gradientLayer: GradationSettable? {
        get {
            if let existed = objc_getAssociatedObject(
                base,
                &UIView.AssociatedKeys.gradientLayer
            ) as? GradationSettable { return existed }
            let new = __Zon_Gradation(view: base)
            objc_setAssociatedObject(
                base,
                &UIView.AssociatedKeys.gradientLayer,
                new,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            return new
        }
        set {
            objc_setAssociatedObject(
                base,
                &UIView.AssociatedKeys.gradientLayer,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    fileprivate class __Zon_Gradation: GradationSettable {
        weak var view: UIView?
        let layer = CAGradientLayer()
        init(view: UIView) {
            self.view = view
            view.layer.addSublayer(layer)
            layer.frame = view.bounds

            let layoutSubviewsBlock: @convention(block)(AspectInfo) -> Void = { [weak self] _ in
                self?.layer.frame = self?.view?.bounds ?? .zero
            }
            let viewClass = type(of: view)
            _ = try? view.aspect_hook(
                #selector(viewClass.layoutSubviews),
                usingBlock: layoutSubviewsBlock
            )
        }

        var locations: [CGFloat] = [] {
            didSet { layer.locations = locations.map { $0 as NSNumber } }
        }
        var colors: [UIColor] = [] {
            didSet { layer.colors = colors.compactMap { $0.cgColor } }
        }
        var startPoint: CGPoint = .zero {
            didSet { layer.startPoint = startPoint }
        }
        var endPoint: CGPoint = .zero {
            didSet { layer.endPoint = endPoint }
        }
    }
}
extension UIView {
    fileprivate struct AssociatedKeys {
        static var hotspot: UInt8 = 0
        static var gradientLayer: UInt8 = 0
    }
}
