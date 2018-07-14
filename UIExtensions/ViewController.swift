//
//  ViewController.swift
//  UIExtensions
//
//  Created by FunctionMaker on 2017/12/6.
//  Copyright © 2017年 FunctionMaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testImageView: UIImageView!
    @IBOutlet weak var testLabel: UILabel!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        testImageView.asMenuTrigger([MenuItem(title: "test", action: #selector(testAction))])
    }
    
    @objc func testAction() {
        debugPrint("test edit action occur")
    }
}

