//
//  SafeJsonObject.swift
//  SnacMap
//
//  Created by Sander Rõuk on 07/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import Foundation

//This class helps future proof the classes subclassing this class, otherwise if a selector changes the code becomes unusable.
class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        
        let range = key.rangeOfComposedCharacterSequence(at: key.startIndex)
        let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        super.setValue(value, forKey: key)
    }
}
