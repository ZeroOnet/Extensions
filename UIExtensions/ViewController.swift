//
//  ViewController.swift
//  UIExtensions
//
//  Created by FunctionMaker on 2017/12/6.
//  Copyright © 2017年 FunctionMaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.copyable()
    }
}

