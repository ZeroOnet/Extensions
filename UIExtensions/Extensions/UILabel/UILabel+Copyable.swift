//
//  UILabel+Copyable.swift
//  UIExtensions
//
//  Created by 李文康 on 2018/7/10.
//  Copyright © 2018 FunctionMaker. All rights reserved.
//

import UIKit

extension UILabel {
    /// this system method will be called when default copy action occured
    open override func copy(_ sender: Any?) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }
}
