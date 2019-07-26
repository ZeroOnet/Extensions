//
//  UIView+Frame.swift
//  UIExtensions
//
//  Created by FunctionMaker on 2017/12/9.
//  Copyright © 2017年 FunctionMaker. All rights reserved.
//

import UIKit

extension Zonable where Base: UIView {
    var x: CGFloat {
        return base.frame.origin.x
    }
    
    var y: CGFloat {
        return base.frame.origin.y
    }
    
    var width: CGFloat {
        return base.bounds.width
    }
    
    var height: CGFloat {
        return base.bounds.height
    }
    
    var origin: CGPoint {
        return base.frame.origin
    }
    
    var size: CGSize {
        return base.bounds.size
    }
    
    func setX(_ x: CGFloat) {
        var frame = base.frame
        frame.origin.x = x
        
        base.frame = frame
    }
    
    func setY(_ y: CGFloat) {
        var frame = base.frame
        frame.origin.y = y
        
        base.frame = frame
    }
    
    func setWidth(_ width: CGFloat) {
        var bounds = base.bounds
        bounds.size.width = width
        
        base.bounds = bounds
    }
    
    func setHeight(_ height: CGFloat) {
        var bounds = base.bounds
        bounds.size.height = height
        
        base.bounds = bounds
    }
    
    func setOrigin(_ origin: CGPoint) {
        var frame = base.frame
        frame.origin = origin
        
        base.frame = frame
    }
    
    func setSize(_ size: CGSize) {
        var bounds = base.bounds
        bounds.size = size
        
        base.bounds = bounds
    }
}
