//
//  UIStackView+Extensions.swift
//  Extensions
//
//  Created by 李文康 on 2023/10/25.
//  Copyright © 2023 FunctionMaker. All rights reserved.
//

extension Zonable where Base: UIStackView {
    func removeAllArrangedSubviews() {
        for arv in base.arrangedSubviews {
            base.removeArrangedSubview(arv)

            // Import: deactivate constraint and remove from superview.
            NSLayoutConstraint.deactivate(arv.constraints)
            arv.removeFromSuperview()
        }
    }
}
