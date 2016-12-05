//
//  ViewController.swift
//  SnacMap
//
//  Created by Sander Rõuk on 05/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import UIKit

class StartScreenController: UIViewController {
    
    let startScreenView = StartScreenView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SnacMap"
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        //Add subviews
        view.addSubview(startScreenView)
        
        //Setup their constraints
        _ = startScreenView.anchorTo(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
}

