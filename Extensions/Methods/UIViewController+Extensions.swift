//
//  UIViewController+Extensions.swift
//  Extensions
//
//  Created by 李文康 on 2023/10/23.
//  Copyright © 2023 FunctionMaker. All rights reserved.
//

import UIKit

extension Zonable where Base: UIViewController {
    /// The time interval of browsing view.
    /// - Warning: Call `enableDurationTrack` at first. 0 is invalid value.
    var duration: TimeInterval {
        assert(base.__zon_tracker != nil, "Call .zon.enableDurationTrack() at first.")
        base.__zon_tracker?.endDate = Date()
        return base.__zon_tracker?.duration ?? 0
    }

    func enableDurationTrack() {
        guard base.__zon_tracker == nil else { return }
        base.__zon_tracker = .init(scene: base)
    }

    func disableDurationTrack() {
        guard base.__zon_tracker != nil else { return }
        base.__zon_tracker = nil
    }
}

private class _DurationTracker {
    var duration: Double = 0
    var startDate: Date?
    var endDate: Date? {
        didSet {
            guard let startDate, let endDate else { return }
            let timeInterval = endDate.timeIntervalSince(startDate)
            if timeInterval > 0 {
                self.startDate = self.endDate
                duration += timeInterval
            }
        }
    }
    init(scene: UIViewController) {
        // ISA Swizzling with `Aspects`
        let viewWillAppearBlock: @convention(block)() -> Void = { [weak self] in
            self?.startDate = Date()

            // notification active & inactive
            let center = NotificationCenter.default
            center.addObserver(forName: .UIApplicationWillResignActive, object: nil, queue: nil) { [weak self] _ in
                self?.endDate = Date()
            }
            center.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: nil) { [weak self] _ in
                self?.startDate = Date()
            }
        }
        let viewWillDisappearBlock: @convention(block)() -> Void = { [weak self] in
            guard let self else { return }
            self.endDate = Date()
            // swiftlint:disable:next notification_center_detachment
            NotificationCenter.default.removeObserver(self)
        }
        let type = type(of: scene)
        _ = try? scene.aspect_hook(#selector(type.viewWillAppear(_:)), usingBlock: viewWillAppearBlock)
        _ = try? scene.aspect_hook(#selector(type.viewWillDisappear(_:)), usingBlock: viewWillDisappearBlock)
    }
}

extension UIViewController {
    fileprivate struct AssociatedKeys {
        static var tracker: UInt8 = 0
    }

    fileprivate var __zon_tracker: _DurationTracker? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.tracker) as? _DurationTracker
        }

        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tracker, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
