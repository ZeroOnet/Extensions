//
//  ViewController.swift
//  UIExtensions
//
//  Created by FunctionMaker on 2017/12/6.
//  Copyright © 2017年 FunctionMaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.center = self.view.center
        button.backgroundColor = UIColor.lightGray
        
        button.setTitle("try", for: .normal)
        
        let image = UIImage(named: "arrow")
        button.setImage(image, imageAlignment: .right, spacing: 20, state: .normal)
        button.setWidth(150)
        button.setHeight(150)
        
        self.view.addSubview(button)
    }
}

