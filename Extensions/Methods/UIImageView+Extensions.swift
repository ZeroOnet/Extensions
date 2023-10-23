//
//  UIImageView+SaveImage.swift
//  UIExtensions
//
//  Created by 李文康 on 07/02/2018.
//  Copyright © 2018 FunctionMaker. All rights reserved.
//

import Photos
import UIKit

extension Zonable where Base: UIImageView {
    enum FailureReason: Error {
        case invalidImage
        case unknownError
        case saveFailed(Error)
    }

    /// Save image to album
    /// - Warning: permission of NSPhotoLibraryAddUsageDescription is needed.
    func saveImage(completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let image = base.image else { completion(.failure(FailureReason.invalidImage)); return }
        PHPhotoLibrary.shared()
            .performChanges({ PHAssetChangeRequest.creationRequestForAsset(from: image) },
                completionHandler: { flag, error in
                    if flag { completion(.success(image)) }
                    else if let error { completion(.failure(FailureReason.saveFailed(error))) }
                    else { completion(.failure(FailureReason.unknownError)) }
                }
            )
    }
}
