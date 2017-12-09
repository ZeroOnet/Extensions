//
//  UIButton+ImageAlignment.swift
//  UIExtensions
//
//  Created by FunctionMaker on 2017/12/9.
//  Copyright © 2017年 FunctionMaker. All rights reserved.
//

import UIKit

/// button's imageView alignment
///
/// - left: in the left of titleLabel
/// - right: in the right of titleLabel
/// - top: in the top of titleLabel
/// - bottom: in the bottom of titleLabel
enum ImageAlignment {
    case left
    case right
    case top
    case bottom
}

extension UIButton {
    /// adjust the locations of imageView and titleLabel
    ///
    /// - Parameters:
    ///   - image: imageView's image
    ///   - imageAlignment: imageView's location relative to titleLabel
    ///   - spacing: the margin of imageView and titleLabel
    ///   - for: button's control state
    func setImage(_ image: UIImage?, imageAlignment: ImageAlignment, spacing: CGFloat, for: UIControlState) {
        
    }
}
