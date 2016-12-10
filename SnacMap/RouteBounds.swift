//
//  RouteBounds.swift
//  SnacMap
//
//  Created by Sander Rõuk on 10/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import Foundation

class RouteBounds: SafeJsonObject {
    var northeast: Location?
    var southwest: Location?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if let dictValue = value as? [String: AnyObject] {
            if key == "northeast" {
                northeast = Location()
                northeast?.setValuesForKeys(dictValue)
            } else if key == "southwest" {
                southwest = Location()
                southwest?.setValuesForKeys(dictValue)
            } else {
                super.setValue(value, forKey: key)
            }
        }
    }
}
