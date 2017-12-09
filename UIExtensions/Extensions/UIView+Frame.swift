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
        return self.frame.width
    }
    
    var zn_height: CGFloat {
        return self.frame.height
    }
    
    var zn_origin: CGPoint {
        return self.frame.origin
    }
    
    var zn_size: CGSize {
        return self.frame.size
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
        var frame = self.frame
        frame.size.width = width
        
        self.frame = frame
    }
    
    func setHeight(_ height: CGFloat) {
        var frame = self.frame
        frame.size.height = height
        
        self.frame = frame
    }
    
    func setOrigin(_ origin: CGPoint) {
        var frame = self.frame
        frame.origin = origin
        
        self.frame = frame
    }
    
    func setSize(_ size: CGSize) {
        var frame = self.frame
        frame.size = size
        
        self.frame = frame
    }
}
