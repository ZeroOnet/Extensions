//
//  UINavigationController+Extensions.swift
//  Extensions
//
//  Created by 李文康 on 2023/10/25.
//  Copyright © 2023 FunctionMaker. All rights reserved.
//

extension Zonable where Base: UINavigationController {
    /// Get a visiable navigation controller can push and pop view controller.
    static var currentAvailable: UINavigationController? {
        // https://developer.apple.com/forums/thread/695932
        // replace delegate window instead of application key window.
        guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else { return nil }

        var destinationScene: UIViewController? = rootViewController

        if let tabBarScene = rootViewController as? UITabBarController {
            destinationScene = tabBarScene.presentedViewController != nil
                ? tabBarScene : tabBarScene.selectedViewController
        }

        while destinationScene?.presentedViewController != nil {
            destinationScene = destinationScene?.presentedViewController.unsafelyUnwrapped

            if let navigationScene = destinationScene as? UINavigationController {
                destinationScene = navigationScene.topViewController
            } else if let tabBarScene = destinationScene as? UITabBarController {
                if tabBarScene.presentedViewController != nil {
                    continue
                } else {
                    destinationScene = tabBarScene.selectedViewController
                }
            }
        }

        // navigationController.navigationController is nil.
        return (destinationScene as? UINavigationController) ?? destinationScene?.navigationController
    }
}
