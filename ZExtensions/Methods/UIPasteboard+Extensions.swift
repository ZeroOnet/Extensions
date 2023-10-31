//
//  UIPasteboard+Extensions.swift
//  Extensions
//
//  Created by 李文康 on 2023/10/25.
//  Copyright © 2023 FunctionMaker. All rights reserved.
//

// Get/Set string from pasteboard directly will cause main thread to stall by analyzing MetricKit diagnostic of hang.
extension Zonable where Base: UIPasteboard {
    func string(completion: @escaping (String?) -> Void) {
        let completion = { value in
            DispatchQueue.main.async { completion(value) }
        }

        base.__zon_queue.async {
            guard base.hasStrings else { completion(nil); return }
            completion(base.string)
        }
    }

    func set(string: String, completion: (() -> Void)? = nil) {
        base.__zon_queue.async {
            base.string = string

            if let completion = completion { DispatchQueue.main.async { completion() } }
        }
    }

    func strings(completion: @escaping ([String]?) -> Void) {
        let completion = { value in
            DispatchQueue.main.async { completion(value) }
        }

        base.__zon_queue.async {
            guard base.hasStrings else { completion(nil); return }
            completion(base.strings)
        }
    }

    func set(strings: [String], completion: (() -> Void)? = nil) {
        base.__zon_queue.async {
            base.strings = strings

            if let completion = completion { DispatchQueue.main.async { completion() } }
        }
    }

    func image(completion: @escaping (UIImage?) -> Void) {
        let completion = { value in
            DispatchQueue.main.async { completion(value) }
        }

        base.__zon_queue.async {
            guard base.hasImages else { completion(nil); return }
            completion(base.image)
        }
    }

    func set(image: UIImage, completion: (() -> Void)? = nil) {
        base.__zon_queue.async {
            base.image = image

            if let completion = completion { DispatchQueue.main.async { completion() } }
        }
    }

    func images(completion: @escaping ([UIImage]?) -> Void) {
        let completion = { value in
            DispatchQueue.main.async { completion(value) }
        }

        base.__zon_queue.async {
            guard base.hasImages == true else { completion(nil); return }
            completion(base.images)
        }
    }

    func set(images: [UIImage], completion: (() -> Void)? = nil) {
        base.__zon_queue.async {
            base.images = images

            if let completion = completion { DispatchQueue.main.async { completion() } }
        }
    }
}

extension UIPasteboard {
    fileprivate struct AssociatedKeys {
        static var queue: UInt8 = 0
    }

    fileprivate var __zon_queue: DispatchQueue {
        let storedQueue = objc_getAssociatedObject(self, &AssociatedKeys.queue) as? DispatchQueue

        if let storedQueue = storedQueue {
            return storedQueue
        } else {
            let aQueue = DispatchQueue(label: "com.zon.pasteboard.queue")
            objc_setAssociatedObject(self, &AssociatedKeys.queue, aQueue, .OBJC_ASSOCIATION_RETAIN)

            return aQueue
        }
    }
}
