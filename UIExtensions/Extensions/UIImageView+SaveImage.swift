//
//  UIImageView+SaveImage.swift
//  UIExtensions
//
//  Created by 李文康 on 07/02/2018.
//  Copyright © 2018 FunctionMaker. All rights reserved.
//

import UIKit

private var kFinishedKey: UInt8 = 0
private var kFailedKey: UInt8 = 1

extension UIImageView {
    
    /// use Runtime to store call back handlers
    private var finishedHandler: ((UIImage) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &kFinishedKey) as? (UIImage) -> Void
        }
        set {
            return objc_setAssociatedObject(self, &kFinishedKey, finishedHandler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var failedHandler: ((Error) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &kFailedKey) as? (Error) -> Void
        }
        set {
            return objc_setAssociatedObject(self, &kFailedKey, failedHandler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// save the image of image view by a simple way
    ///
    /// - Parameters:
    ///   - finishedHandler: if finished saving, it will call back this handler
    ///   - failedHandler: if failed saving, it will call back this handler
    func saveImage(finishedHandler: ((UIImage) -> Void)? = nil, failedHandler: ((Error) -> Void)? = nil) {
        self.finishedHandler = finishedHandler
        self.failedHandler = failedHandler
        
        guard let image = image else {
            debugPrint("the image don't exist")
            return
        }
        
        // we must get graphics image after drawing, otherwise, it save fails.
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        image.draw(in: bounds)
        
        let savedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let savedImage = savedImage {
            UIImageWriteToSavedPhotosAlbum(savedImage, self, #selector(imageSaveFinished(image:error:content:)), nil)
        }
    }
    
    @objc func imageSaveFinished(image: UIImage, error: Error?, content: UnsafeRawPointer) {
        if let error = error {
            failedHandler?(error)
        } else {
            finishedHandler?(image)
        }
    }
}
