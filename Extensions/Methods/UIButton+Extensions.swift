//
//  UIButton+ImageAlignment.swift
//  UIExtensions
//
//  Created by FunctionMaker on 2017/12/9.
//  Copyright © 2017年 FunctionMaker. All rights reserved.
//

import UIKit

extension Zonable where Base: UIButton {
    /// button's imageView alignment
    ///
    /// - top: in the left of titleLabel
    /// - left: in the right of titleLabel
    /// - bottom: in the top of titleLabel
    /// - right: in the bottom of titleLabel
    enum ImageAlignment {
        case top
        case left
        case bottom
        case right
    }

    /// adjust the locations of imageView and titleLabel
    ///
    /// - Parameters:
    ///   - image: imageView's image
    ///   - imageAlignment: imageView's location relative to titleLabel
    ///   - spacing: the margin of imageView and titleLabel
    ///   - state: button's control state
    func setImage(_ image: UIImage?, imageAlignment: ImageAlignment, spacing: CGFloat = 0, state: UIControl.State) {
        base.setImage(image, for: base.state)

        // back to initial state
        base.imageEdgeInsets = UIEdgeInsets()
        base.titleEdgeInsets = UIEdgeInsets()

        base.sizeToFit()
        base.setNeedsLayout()
        base.layoutIfNeeded()

        let imageViewWidth = base.imageView?.zon.width ?? 0
        let imageViewHeight = base.imageView?.zon.height ?? 0
        let titleLabelWidth = base.titleLabel?.zon.width ?? 0
        let titleLabelHeight = base.titleLabel?.zon.height ?? 0

        let centerX = (imageViewWidth + titleLabelWidth) / 2.0
        let imageMargin = centerX - imageViewWidth / 2.0
        let titleMargin = centerX - titleLabelWidth / 2.0

        let moveSpacing = spacing / 2.0

        var imageEdgeInsets: UIEdgeInsets
        var titleEdgeInsets: UIEdgeInsets

        // no matter how big the button is, the imageView is close to titleLabel
        switch imageAlignment {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -(imageViewHeight / 2.0 + moveSpacing),
                                           left: imageMargin,
                                           bottom: imageViewHeight / 2.0 + moveSpacing,
                                           right: -imageMargin)
            titleEdgeInsets = UIEdgeInsets(top: titleLabelHeight / 2.0 + moveSpacing,
                                           left: -titleMargin,
                                           bottom: -(titleLabelHeight / 2.0 + moveSpacing),
                                           right: titleMargin)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -moveSpacing,
                                           bottom: 0,
                                           right: moveSpacing)
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: moveSpacing,
                                           bottom: 0,
                                           right: -moveSpacing)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: imageViewHeight / 2.0 + moveSpacing,
                                           left: imageMargin,
                                           bottom: -(imageViewHeight / 2.0 + moveSpacing),
                                           right: -imageMargin)
            titleEdgeInsets = UIEdgeInsets(top: -(titleLabelHeight / 2.0 + moveSpacing),
                                           left: -titleMargin,
                                           bottom: titleLabelHeight / 2.0 + moveSpacing,
                                           right: titleMargin)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: titleLabelWidth + moveSpacing,
                                           bottom: 0,
                                           right: -(titleLabelWidth + moveSpacing))
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -(imageViewWidth + moveSpacing),
                                           bottom: 0,
                                           right: imageViewWidth + moveSpacing)
        }

        base.imageEdgeInsets = imageEdgeInsets
        base.titleEdgeInsets = titleEdgeInsets
    }
}
