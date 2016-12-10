//
//  StartScreenView.swift
//  SnacMap
//
//  Created by Sander Rõuk on 05/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import UIKit

class StartScreenView: UIView {
    
    //Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Define view elements
    let snacMapLabel: UILabel = {
        let label = UILabel()
        label.text = "SnacMap"
        label.font = .boldSystemFont(ofSize: 38)
        return label
    }()
    
    let originLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter origin location:"
        return label
    }()
    
    let destinationLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter destination location:"
        return label
    }()
    
    let originTextField: PaddedTextField = {
        let tf = PaddedTextField()
        tf.placeholder = "Origin"
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = UIColor(white: 0, alpha: 0.2)
        tf.returnKeyType = .next
        tf.autocorrectionType = .no
        return tf
    }()
    
    let destinationTextField: PaddedTextField = {
        let tf = PaddedTextField()
        tf.placeholder = "Destination"
        tf.clearButtonMode = .whileEditing
        tf.returnKeyType = .route
        tf.backgroundColor = UIColor(white: 0, alpha: 0.2)
        tf.autocorrectionType = .no
        return tf
    }()
    
    let navigateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Navigate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    
    //Construct view
    fileprivate func setupSubViews() {
        addSubview(originTextField)
        addSubview(originLabel)
        addSubview(destinationTextField)
        addSubview(destinationLabel)
        addSubview(navigateButton)
        addSubview(snacMapLabel)
        
        _ = originTextField.anchor(width: widthAnchor, centerX: centerXAnchor, centerY: centerYAnchor, centerYConstant: -60, widthConstant: -24, heightConstant: 50)
        _ = originLabel.anchor(bottom: originTextField.topAnchor, left: originTextField.leftAnchor, bottomConstant: -6, heightConstant: 20)
        _ = destinationTextField.anchor(width: widthAnchor, centerX: centerXAnchor, centerY: centerYAnchor, centerYConstant: 60, widthConstant: -24, heightConstant: 50)
        _ = destinationLabel.anchor(bottom: destinationTextField.topAnchor, left: destinationTextField.leftAnchor, bottomConstant: -6, heightConstant: 20)
        _ = navigateButton.anchor(top: destinationTextField.bottomAnchor, width: destinationTextField.widthAnchor, centerX: centerXAnchor, topConstant: 50, heightConstant: 50)
        _ = snacMapLabel.anchor(bottom: originLabel.topAnchor, centerX: centerXAnchor, bottomConstant: -50)
    }

}
