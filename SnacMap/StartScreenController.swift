//
//  ViewController.swift
//  SnacMap
//
//  Created by Sander Rõuk on 05/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import UIKit

class StartScreenController: UIViewController, UITextFieldDelegate {
    
    fileprivate let startScreenView = StartScreenView()
    fileprivate var startScreenViewAnchors: [String: NSLayoutConstraint]?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SnacMap"
        
        setupSubviews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    fileprivate func setupSubviews() {
        //Add subviews
        view.addSubview(startScreenView)
        
        //Setup subviews
        startScreenViewAnchors = startScreenView.anchorTo(centerX: view.centerXAnchor, centerY: view.centerYAnchor, width: view.widthAnchor, height: view.heightAnchor)
        
        //Setup subview targets
        startScreenView.navigateButton.addTarget(self, action: #selector(navigateToMap), for: .touchUpInside)
        
        //Setup subview delegation
        startScreenView.originTextField.delegate = self
        startScreenView.destinationTextField.delegate = self
    }
    
    // Take care of moving the view when showing keyboard
    @objc fileprivate func keyboardWillAppear() {
        startScreenViewAnchors?["centerYAnchor"]?.constant = -125
        UIView.animate(animations: { self.view.layoutIfNeeded() })
    }
    
    @objc fileprivate func keyboardWillDisappear() {
        startScreenViewAnchors?["centerYAnchor"]?.constant = 0
        UIView.animate(animations: { self.view.layoutIfNeeded() })
    }
    
    // Navigate to the next view controller
    @objc fileprivate func navigateToMap(){
        //Check if both origin and destination have content else show alert
        guard let origin = startScreenView.originTextField.text, let destination = startScreenView.destinationTextField.text else {
            displayErrorMessageNoContentInTextFields()
            return
        }
        if origin.isEmpty || destination.isEmpty {
            displayErrorMessageNoContentInTextFields()
            return
        }
        navigationController?.pushViewController(MapController(origin: origin, destination: destination), animated: true)
    }
    
    fileprivate func displayErrorMessageNoContentInTextFields() {
        let alert = UIAlertController(title: "Unable to navigate", message: "Please fill in both the origin and the destination and try again.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Make text field editing more natural
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //If the text field is empty remove keyboard because we want both entries
        if let textFieldEmpty = textField.text?.isEmpty {
            if textFieldEmpty {
                textField.resignFirstResponder()
                return false
            }
        }
        //If editing origin location move to destination, else try to start navigation
        if textField.placeholder == "Origin" {
            startScreenView.destinationTextField.becomeFirstResponder()
        } else {
            navigateToMap()
            textField.resignFirstResponder()
        }
        return false
    }
    
    
}

