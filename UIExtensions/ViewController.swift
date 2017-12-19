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
        
        let QRImageView = UIImageView()
        QRImageView.center = self.view.center
        QRImageView.setWidth(200)
        QRImageView.setHeight(200)
        QRImageView.image = UIImage.qrImage(content: "我 you 🤣", size: CGSize(width: 200, height: 200))
        
        self.view.addSubview(QRImageView)
    }
}

