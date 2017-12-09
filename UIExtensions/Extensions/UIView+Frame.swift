//
//  UIView+Frame.swift
//  UIExtensions
//
//  Created by FunctionMaker on 2017/12/9.
//  Copyright © 2017年 FunctionMaker. All rights reserved.
//

import UIKit

extension UIView {
    var zn_x: CGFloat {
        return self.frame.origin.x
    }
    
    var zn_y: CGFloat {
        return self.frame.origin.y
    }
    
    var zn_width: CGFloat {
        return self.bounds.width
    }
    
    var zn_height: CGFloat {
        return self.bounds.height
    }
    
    var zn_origin: CGPoint {
        return self.frame.origin
    }
    
    var zn_size: CGSize {
        return self.bounds.size
    }
    
    func setX(_ x: CGFloat) {
        var frame = self.frame
        frame.origin.x = x
        
        self.frame = frame
    }
    
    func setY(_ y: CGFloat) {
        var frame = self.frame
        frame.origin.y = y
        
        self.frame = frame
    }
    
    func setWidth(_ width: CGFloat) {
        var bounds = self.bounds
        bounds.size.width = width
        
        self.bounds = bounds
    }
    
    func setHeight(_ height: CGFloat) {
        var bounds = self.bounds
        bounds.size.height = height
        
        self.bounds = bounds
    }
    
    func setOrigin(_ origin: CGPoint) {
        var frame = self.frame
        frame.origin = origin
        
        self.frame = frame
    }
    
    func setSize(_ size: CGSize) {
        var bounds = self.bounds
        bounds.size = size
        
        self.bounds = bounds
    }
}
