//
//  UIStackView+Extensions.swift
//  Extensions
//
//  Created by 李文康 on 2023/10/25.
//  Copyright © 2023 FunctionMaker. All rights reserved.
//

extension Zonable where Base: UIStackView {
    func setPadding(_ padding: UIEdgeInsets) {
        base.isLayoutMarginsRelativeArrangement = true

        if #available(iOS 11.0, *) {
            base.directionalLayoutMargins = .init(
                top: padding.top,
                leading: padding.left,
                bottom: padding.bottom,
                trailing: padding.right
            )
        } else {
            base.layoutMargins = padding
        }
    }

    func setBackgroundColor(_ backgroundColor: UIColor) {
        if #available(iOS 14, *) { base.backgroundColor = backgroundColor; return }
        if let bgView = base.__zon_bgView { bgView.backgroundColor = backgroundColor; return }
        let bgView = UIView(frame: base.bounds)
        bgView.backgroundColor = backgroundColor
        bgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        base.insertSubview(bgView, at: 0)
        base.__zon_bgView = bgView
    }

    func removeAllArrangedSubviews() {
        for arv in base.arrangedSubviews {
            base.removeArrangedSubview(arv)

            // Import: deactivate constraint and remove from superview.
            NSLayoutConstraint.deactivate(arv.constraints)
            arv.removeFromSuperview()
        }
    }
}

extension UIStackView {
    fileprivate struct AssociatedKeys {
        static var backgroundColor: UInt8 = 0
    }

    fileprivate var __zon_bgView: UIView? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.backgroundColor) as? UIView
        }

        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.backgroundColor,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
