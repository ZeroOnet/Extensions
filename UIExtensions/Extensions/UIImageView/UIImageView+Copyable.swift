//
//  UIImageView+Copyable.swift
//  UIExtensions
//
//  Created by 李文康 on 2018/7/14.
//  Copyright © 2018 FunctionMaker. All rights reserved.
//

import UIKit

extension UIImageView {
    /// this system method will be called when default copy action occured
    open override func copy(_ sender: Any?) {
        let pasteboard = UIPasteboard.general
        pasteboard.image = image
    }
}
