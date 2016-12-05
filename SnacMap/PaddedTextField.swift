//
//  PaddedTextField.swift
//  SnacMap
//
//  Created by Sander Rõuk on 06/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import UIKit

class PaddedTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }
}
