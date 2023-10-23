//
//  UIImage+QRCode.swift
//  UIExtensions
//
//  Created by FunctionMaker on 2017/12/19.
//  Copyright © 2017年 FunctionMaker. All rights reserved.
//

import UIKit

extension Zonable where Base: UIImage {
    /// creat a QR code image with content and it's expected size
    ///
    /// - Parameters:
    ///   - content: string content
    ///   - size: expected size
    /// - Returns: result image
    static func qrImage(content: String, size: CGSize) -> UIImage? {
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

    /// creat a gif image with content of url
    ///
    /// - Parameter url: content of url
    /// - Returns: a gif image
    static func gif(contentsOf url: URL) -> UIImage? {
        guard let data = try? Data(contentsOf: url),
            let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else {
                return nil
        }

        let pageCount = CGImageSourceGetCount(imageSource)

        if pageCount <= 1 { return UIImage(data: data) }

        var duration: TimeInterval = 0
        var images: [UIImage] = []

        for index in 0..<pageCount {
            duration += _frameDuration(at: index, source: imageSource)

            if let image = CGImageSourceCreateImageAtIndex(imageSource, index, nil) {
                images.append(UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .up))
            }
        }
        return UIImage.animatedImage(with: images, duration: duration)
    }

    private static func _frameDuration(at index: Int, source: CGImageSource) -> TimeInterval {
        var frameDuration: TimeInterval = 0

        guard let frameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as? [String: Any],
            let gifProperties = frameProperties[kCGImagePropertyGIFDictionary as String] as? [String: Any] else {
                return frameDuration
        }

        if let delayTimeUnclampedProperty = gifProperties[
            kCGImagePropertyGIFUnclampedDelayTime as String
        ] as? TimeInterval {
            frameDuration = delayTimeUnclampedProperty
        } else if let delayTimeProperty = gifProperties[
            kCGImagePropertyGIFDelayTime as String
        ] as? TimeInterval {
            frameDuration = delayTimeProperty
        }

        if frameDuration < 0.011 {
            frameDuration = 0.100
        }
        return frameDuration
    }
}
