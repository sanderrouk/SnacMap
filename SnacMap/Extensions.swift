//
//  Extensions.swift
//  SnacMap
//
//  Created by Sander Rõuk on 05/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

extension UIView {
    class func animate(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: animations, completion: completion)
    }
    
    func anchorTo(top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor, left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor) -> [String: NSLayoutConstraint]{
        return anchor(top: top, bottom: bottom, left: left, right: right)
    }
    
    func anchorTo(centerX: NSLayoutXAxisAnchor, centerY: NSLayoutYAxisAnchor, width: NSLayoutDimension, height: NSLayoutDimension) -> [String: NSLayoutConstraint] {
        return anchor(width: width, height: height, centerX: centerX, centerY: centerY)
    }
    
    func anchorTo(centerX: NSLayoutXAxisAnchor, centerY: NSLayoutYAxisAnchor, widthConstant: CGFloat, heightConstant: CGFloat) -> [String: NSLayoutConstraint] {
        return anchor(centerX: centerX, centerY: centerY, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    func anchorTo(centerX: NSLayoutXAxisAnchor, centerY: NSLayoutYAxisAnchor, centerXConstant: CGFloat, centerYConstant: CGFloat, widthConstant: CGFloat, heightConstant: CGFloat) -> [String: NSLayoutConstraint] {
        return anchor(centerX: centerX, centerY: centerY, centerXConstant: centerXConstant, centerYConstant: centerYConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    /// This basically just anchors your view to wherever you want it to be anchored with much less effort.
    func anchor(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, width: NSLayoutDimension? = nil, height: NSLayoutDimension? = nil, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat? = nil, bottomConstant: CGFloat? = nil, leftConstant: CGFloat? = nil, rightConstant: CGFloat? = nil, centerXConstant: CGFloat? = nil, centerYConstant: CGFloat? = nil, widthConstant: CGFloat? = nil, heightConstant: CGFloat? = nil) -> [String: NSLayoutConstraint] {
        
        //Setup
        var layoutConstraints = [String: NSLayoutConstraint]()
        translatesAutoresizingMaskIntoConstraints = false
        //Set constraints
        if let top = top {
            layoutConstraints["top"] = topAnchor.constraint(equalTo: top)
        }
        if let bottom = bottom {
            layoutConstraints["bottom"] = bottomAnchor.constraint(equalTo: bottom)
        }
        if let left = left {
            layoutConstraints["left"] = leftAnchor.constraint(equalTo: left)
        }
        if let right = right {
            layoutConstraints["right"] = rightAnchor.constraint(equalTo: right)
        }
        if let width = width {
            layoutConstraints["width"] = widthAnchor.constraint(equalTo: width)
        }
        if let height = height {
            layoutConstraints["height"] = heightAnchor.constraint(equalTo: height)
        }
        if let centerX = centerX {
            layoutConstraints["centerXAnchor"] = centerXAnchor.constraint(equalTo: centerX)
        }
        if let centerY = centerY {
            layoutConstraints["centerYAnchor"] = centerYAnchor.constraint(equalTo: centerY)
        }
        //Set constants
        if let topConstant = topConstant {
            layoutConstraints["top"]?.constant = topConstant
        }
        if let bottomConstant = bottomConstant {
            layoutConstraints["bottom"]?.constant = bottomConstant
        }
        if let leftConstant = leftConstant {
            layoutConstraints["left"]?.constant = leftConstant
        }
        if let rightConstant = rightConstant {
            layoutConstraints["right"]?.constant = rightConstant
        }
        if let centerXConstant = centerXConstant {
            layoutConstraints["centerXAnchor"]?.constant = centerXConstant
        }
        if let centerYConstant = centerYConstant {
            layoutConstraints["centerYAnchor"]?.constant = centerYConstant
        }
        //Special constants
        if let widthConstant = widthConstant {
            if let constraint = layoutConstraints["width"]{
                constraint.constant = widthConstant
            } else {
                layoutConstraints["widthConstant"] = widthAnchor.constraint(equalToConstant: widthConstant)
            }
        }
        if let heightConstant = heightConstant {
            if let constraint = layoutConstraints["height"]{
                constraint.constant = heightConstant
            } else {
                layoutConstraints["heightConstant"] = heightAnchor.constraint(equalToConstant: heightConstant)
            }
        }
        //Activate all of them
        layoutConstraints.forEach { (key: String, value: NSLayoutConstraint) in
            value.isActive = true
        }
        return layoutConstraints
    }
}
