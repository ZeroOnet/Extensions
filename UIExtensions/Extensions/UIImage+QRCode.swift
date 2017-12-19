//
//  UIImage+QRCode.swift
//  UIExtensions
//
//  Created by 李文康 on 2017/12/19.
//  Copyright © 2017年 FunctionMaker. All rights reserved.
//

import UIKit

extension UIImage {
    /// creat a QR code image with content and it's expected size
    ///
    /// - Parameters:
    ///   - content: string content
    ///   - size: expected size
    /// - Returns: result image
    class func qrImage(content: String, size: CGSize) -> UIImage? {
        let data = content.data(using: .utf8, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // the input message must be the instance of Data / NSData
        filter?.setValue(data, forKey: "inputMessage")
        // default is M: the 15% of bits can be corrected
        // filter?.setValue("H", forKey: "inputCorrectionLevel")
        
        guard let outputImage = filter?.outputImage else { return nil }
        
        // the original output image of filter is small, so we should adjust it's size
        let scaleX = size.width / outputImage.extent.width
        let scaleY = size.height / outputImage.extent.height
        
        let scaledOutputImage = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        return UIImage(ciImage: scaledOutputImage)
    }
}
